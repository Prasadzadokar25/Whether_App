import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pweather/Model/app_data.dart';
import 'package:pweather/Model/webL_links.dart';
import 'package:pweather/Model/my_data.dart';
import '../Controller/feach_location.dart';
import '../Model/whether_data.dart';
import '../view/whetheranimation.dart';
import '../Controller/feach_data.dart';
import '../Model/dataiterm_model.dart';
import 'astroposition.dart';
import 'weatherconditionicon.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double hourDataContainerWidth = 67;
  DateTime currentTime = DateTime.now();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentHour();
    });
    _fetchWeatherData();
    setState(() {});
  }

  Future<void> _fetchWeatherData() async {
    final whetherData = await FeachData.feachWetherInfo(
        await FeachLocation.determinePosition());
    setState(() {
      //  Data.whetherData = whetherData;
      log("${whetherData.toJson()['current']['temp_c']}");
    });
  }

  void _scrollToCurrentHour() async {
    int currentHour = currentTime.hour;
    double itemWidth = hourDataContainerWidth;
    if (Data.whetherData!.forecast!.forecastday![0].hour!.isNotEmpty) {
      _scrollController.animateTo(
        currentHour * itemWidth * 1.1,
        duration: const Duration(seconds: 4),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WhetherData? whetherData = Data.whetherData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return (whetherData!.current != null)
        ? Scaffold(
            backgroundColor: const Color.fromARGB(255, 19, 19, 19),
            extendBodyBehindAppBar: true,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(18, kToolbarHeight, 18, 8),
              child: SizedBox(
                height: height,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(3, -0.3),
                      child: Container(
                        height: 300,
                        width: width * 0.9,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-3, -0.3),
                      child: Container(
                        height: 300,
                        width: width * 0.9,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF673AB7)),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, -0.85),
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(251, 232, 151, 12)),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(0, 200, 15, 15)),
                      ),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        Data.whetherData = await FeachData.feachWetherInfo(
                            await FeachLocation.determinePosition());
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            MyHoverBackGround(
                              radius: 10,
                              child: GestureDetector(
                                onTap: () {
                                  _launchApp(url: AppData.mainTempUrl);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 150,
                                              width: width / 1.5,
                                              child: CloudAnimation(),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: height * 0.19,
                                          alignment: Alignment.center,
                                          child: WeatherConditionIcon(
                                              code: whetherData
                                                  .current!.condition!.code!,
                                              isDay:
                                                  whetherData.current!.isDay!),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: (whetherData.current != null)
                                          ? Text(
                                              " ${whetherData.current!.tempC!.round()}°",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 75,
                                                fontWeight: FontWeight.w600,
                                              ))
                                          : const Text(
                                              "Not avalable at this movement ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ),
                                    Text(
                                      Data.whetherData!.location!.localtime!
                                          .split(" ")[0],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 300,
                                      child: Text(
                                        (Data.whetherData!.current!.condition!
                                                    .text !=
                                                null)
                                            ? Data.whetherData!.current!
                                                .condition!.text!
                                            : "No whether massege avaleble",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 225, 222, 222),
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(82, 44, 43, 43),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  otherInfoButton(
                                      label: "Wind",
                                      value:
                                          "${whetherData.current!.windKph!.round()} km/h",
                                      icon: const Icon(
                                        Icons.air_rounded,
                                        color:
                                            Color.fromARGB(255, 241, 244, 174),
                                      ),
                                      launchUrl: AppData.windUrl),
                                  Container(
                                    width: 1.6,
                                    height: 40,
                                    color: const Color.fromARGB(
                                        255, 177, 175, 175),
                                  ),
                                  otherInfoButton(
                                      label: "Humidity",
                                      value:
                                          "${whetherData.current!.humidity}%",
                                      icon: const Icon(
                                        Icons.water_drop,
                                        color:
                                            Color.fromARGB(255, 122, 217, 244),
                                      ),
                                      launchUrl: AppData.humidityUrl),
                                  Container(
                                    width: 1.6,
                                    height: 40,
                                    color: const Color.fromARGB(
                                        255, 177, 175, 175),
                                  ),
                                  otherInfoButton(
                                      label: "Rain",
                                      value: (whetherData.forecast!.forecastday!
                                              .isNotEmpty)
                                          ? "${whetherData.forecast!.forecastday![0].day!.dailyChanceOfRain}%"
                                          : "Not avalable",
                                      icon: const Icon(
                                        Icons.cloud,
                                        color:
                                            Color.fromARGB(255, 249, 249, 247),
                                      ),
                                      launchUrl: AppData.rainUrl),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              height: 200,
                              width: width,
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Today",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.7,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          
                                        },
                                        child: const Row(
                                          children: [
                                            Text(
                                              "7 days ",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 140, 139, 139),
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.7,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: Color.fromARGB(
                                                  255, 140, 139, 139),
                                              size: 17,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 135,
                                    child: (whetherData
                                            .forecast!.forecastday!.isNotEmpty)
                                        ? ListView.builder(
                                            controller: _scrollController,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: whetherData.forecast!
                                                .forecastday![0].hour!.length,
                                            itemBuilder: (context, index) {
                                              return HourWeatherCard(
                                                index: index,
                                                cardWidth:
                                                    hourDataContainerWidth,
                                              );
                                            },
                                          )
                                        : const Center(
                                            child: Text("No data avalebale"),
                                          ),
                                  )
                                ],
                              ),
                            ),
                            MyHoverBackGround(
                              radius: 18,
                              child: GestureDetector(
                                onTap: () {
                                  _launchApp(url: AppData.sunReportUrl);
                                },
                                child: Container(
                                  height: 105,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(82, 44, 43, 43),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  alignment: Alignment.center,
                                  child: SunPositionScreen(
                                    sunrise: parseTime(whetherData.forecast!
                                        .forecastday![0].astro!.sunrise!),
                                    sunset: parseTime(whetherData.forecast!
                                        .forecastday![0].astro!.sunset!),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyHoverBackGround(
                              radius: 18,
                              child: GestureDetector(
                                onTap: () {
                                  _launchApp(url: AppData.moonReportUrl);
                                },
                                child: Container(
                                  height: 105,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(82, 44, 43, 43),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  alignment: Alignment.center,
                                  child: const MoonLocation(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MyHoverBackGround(
                              radius: 18,
                              child: GestureDetector(
                                onTap: () {
                                  _launchApp(url: AppData.sunReportUrl);
                                },
                                child: const AirQuality(),
                              ),
                            ),
                            const SizedBox(child: MyGridView()),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(82, 44, 43, 43),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Column(
                                children: [
                                  getActivityStatus(
                                    name: "Pollen",
                                    icon: Icons.stream_sharp,
                                    value: "None",
                                  ),
                                  getActivityStatus(
                                    name: "Running",
                                    icon: Icons.directions_run_rounded,
                                    value: "Poor",
                                  ),
                                  getActivityStatus(
                                    name: "Driving difficultywet",
                                    icon: Icons.drive_eta,
                                    value: "Wet",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _launchApp(url: MyData.linkdinUrl);
                                  },
                                  child: const Text(
                                    "PDevelopment",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 183, 182, 182),
                                        fontSize: 12),
                                  ),
                                ),
                                Text(
                                  "Updated: ${whetherData.current!.lastUpdated!.split(" ")[0]}  |  ${whetherData.current!.lastUpdated!.split(" ")[1]}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 183, 182, 182),
                                      fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget getActivityStatus(
      {required String name, required IconData icon, required String value}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  // The method convert String in DateTime format
  // String requred in hour:min or hour:min AM/PM format
  DateTime parseTime(String time) {
    final minHourTime = time.split(" ")[0];
    final now = DateTime.now();
    final parts = minHourTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    if (time.endsWith("pm") || time.endsWith("PM")) {
      return DateTime(now.year, now.month, now.day, hour + 12, minute);
    }
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

// The method that create buttons for Wind seep, humidity and Rain persentage ingo
  Widget otherInfoButton({
    required String label,
    required String value,
    required Icon icon,
    required String launchUrl,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;

    return MyHoverBackGround(
      radius: 10,
      child: GestureDetector(
        onTap: () {
          _launchApp(url: launchUrl);
        },
        child: SizedBox(
          height: 65,
          width: screenWidth * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(25, 236, 178, 3),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: icon,
              ),
              Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white),
              ),
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 170, 168, 168)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AirQuality extends StatefulWidget {
  const AirQuality({super.key});

  @override
  State<AirQuality> createState() => _AirQualityState();
}

//temp correction
class _AirQualityState extends State<AirQuality> {
  @override
  Widget build(BuildContext context) {
    WhetherData? whetherData = Data.whetherData;
    int usEpaIndex = 1;
    if (whetherData!.current!.airQuality != null &&
        whetherData.current!.airQuality!.usEpaIndex != null) {
      usEpaIndex = whetherData.current!.airQuality!.usEpaIndex!;
    }
    double width = MediaQuery.of(context).size.width;
    double calculateQirQulityPersentage(int value) {
      return value / 6; // divide by 6 becouse total categories are 6
    }

    Color getairQuilityColor(int value) {
      switch (value) {
        case 1:
          return const Color.fromARGB(255, 53, 219, 59);
        case 2:
          return const Color.fromARGB(255, 112, 216, 64);
        case 3:
          return const Color.fromARGB(255, 178, 200, 15);
        case 4:
          return const Color.fromARGB(255, 221, 211, 18);
        case 5:
          return const Color.fromARGB(255, 230, 125, 19);
        default:
          return const Color.fromARGB(255, 230, 44, 19);
      }
    }

    String getAirQulityStatus(int value) {
      switch (value) {
        case 1:
          return "Good";
        case 2:
          return "Moderate";
        case 3:
          return "Unhealthy for Sensitive Groups";
        case 4:
          return "Unhealthy";
        case 5:
          return "Very Unhealthy";
        default:
          return "Hazardous";
      }
    }

    return Container(
      height: 100,
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Color.fromARGB(82, 44, 43, 43),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        children: [
          const Text(
            "Air Quality",
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 214, 212, 212),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            getAirQulityStatus(usEpaIndex),
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 214, 212, 212),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: width * 0.75,
              child: LinearProgressIndicator(
                value: calculateQirQulityPersentage(usEpaIndex),
                minHeight: 8,
                color: getairQuilityColor(usEpaIndex),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )),
        ],
      ),
    );
  }
}

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    WhetherData whetherData = Data.whetherData!;
    List termsInfo = [
      DataIterm(
          label: "Pressure",
          value: "${whetherData.current!.pressureMb!}",
          unit: "mb",
          icon: const Icon(
            Icons.vertical_align_center_sharp,
            color: Color.fromARGB(255, 239, 236, 216),
          ),
          launchUrl: AppData.pressureReportUrl),
      DataIterm(
          label: "Dew Point",
          value: "${whetherData.current!.dewpointC!}",
          unit: "°",
          icon: const Icon(
            Icons.water_drop,
            color: Color.fromARGB(255, 239, 236, 216),
          ),
          launchUrl: AppData.dewReportUrl),
      DataIterm(
          label: "Wind",
          value: "${whetherData.current!.windKph!}",
          unit: "km/hr | ${whetherData.current!.windDir}",
          icon: const Icon(
            Icons.air,
            color: Color.fromARGB(255, 239, 236, 216),
          ),
          launchUrl: AppData.windUrl),
      DataIterm(
          label: "UV Index",
          value: "${whetherData.current!.uv!}",
          icon: const Icon(
            Icons.sunny,
            color: Color.fromARGB(255, 239, 236, 216),
          ),
          launchUrl: AppData.uvIndexReportUrl),
      DataIterm(
        label: "Visibility",
        // ignore: unnecessary_cast
        value: "${whetherData.current!.visKm! as double}",
        unit: "km",
        icon: const Icon(
          Icons.remove_red_eye,
          color: Color.fromARGB(255, 239, 236, 216),
        ),
      ),
      DataIterm(
        label: "HeatIndex",
        value: "${whetherData.current!.heatindexC!}",
        icon: const Icon(
          Icons.hot_tub_sharp,
          color: Color.fromARGB(255, 239, 236, 216),
        ),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.9),
      itemCount: termsInfo.length,
      itemBuilder: (context, index) {
        DataIterm dataIterm = termsInfo[index];
        return MyHoverBackGround(
          radius: 20,
          child: GestureDetector(
            onTap: () {
              if (dataIterm.launchUrl != null) {
                _launchApp(url: dataIterm.launchUrl!);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(124, 38, 38, 38),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      dataIterm.icon!,
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        dataIterm.label,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 214, 212, 212),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${dataIterm.value} ${(dataIterm.unit != null) ? dataIterm.unit : ""}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HourWeatherCard extends StatefulWidget {
  final int index;
  final double cardWidth;
  const HourWeatherCard(
      {required this.index, required this.cardWidth, super.key});

  @override
  State<HourWeatherCard> createState() => _HourWeatherCardState();
}

class _HourWeatherCardState extends State<HourWeatherCard> {
  @override
  Widget build(BuildContext context) {
    WhetherData whetherData = Data.whetherData!;
    DateTime currentTime = DateTime.now();
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 16.7),
        height: (widget.index == currentTime.hour) ? 106 : 100,
        width: widget.cardWidth,
        decoration: (widget.index == currentTime.hour)
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 4, 122, 248),
                    Color.fromARGB(255, 172, 211, 243)
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(119, 22, 146, 247),
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              )
            : BoxDecoration(
                color: const Color.fromARGB(50, 102, 102, 102),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                border:
                    Border.all(color: const Color.fromARGB(255, 60, 57, 57)),
              ),
        child: MyHoverBackGround(
          radius: 25,
          child: GestureDetector(
            onTap: () {
              _launchApp(url: AppData.hourlyReportUrl);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${whetherData.forecast!.forecastday![0].hour![widget.index].tempC!.round()}°",
                    style: TextStyle(
                      color: (widget.index == currentTime.hour)
                          ? Colors.white
                          : const Color.fromARGB(255, 192, 190, 190),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(53, 224, 235, 101),
                            blurRadius: 15,
                          )
                        ],
                      ),
                      child: WeatherConditionIcon(
                          code: whetherData.forecast!.forecastday![0]
                              .hour![widget.index].condition!.code!,
                          isDay: whetherData.forecast!.forecastday![0]
                              .hour![widget.index].isDay!)),
                  Text(
                    whetherData
                        .forecast!.forecastday![0].hour![widget.index].time!
                        .split(" ")[1],
                    style: TextStyle(
                      color: (widget.index == currentTime.hour)
                          ? Colors.white
                          : const Color.fromARGB(255, 192, 190, 190),
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TemperatureChart extends StatelessWidget {
  final List<double> hourlyTemperatures;

  const TemperatureChart({super.key, required this.hourlyTemperatures});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // final hour = value.toInt();
                  return const Text('10');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text('$value°C');
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: hourlyTemperatures
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHoverBackGround extends StatefulWidget {
  final Widget? child;
  final double radius;
  const MyHoverBackGround({super.key, this.child, this.radius = 3});
  @override
  State createState() => _MyHoverBackGround();
}

class _MyHoverBackGround extends State<MyHoverBackGround> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color.fromARGB(46, 240, 233, 230)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.radius),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

void _launchApp({required String url}) async {
  const fallbackUrl = MyData.linkdinUrl;

  try {
    // ignore: deprecated_member_use
    await launch(url, forceSafariVC: false, forceWebView: false);
  } catch (e) {
    // ignore: deprecated_member_use
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
