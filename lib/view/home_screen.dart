import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:wether_report_api/Controller/feach_location.dart';
import 'package:wether_report_api/Controller/whether_inherited_widget.dart';
import 'package:wether_report_api/Model/whether_data.dart';
import 'package:wether_report_api/view/whetheranimation.dart';
import '../Controller/feach_data.dart';
import 'astroposition.dart';
import 'weatherconditionicon.dart';

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
      WhetherInheritedWidget.of(context).whetherData = whetherData;
      log("${whetherData.toJson()['current']['temp_c']}");
    });
  }

  void _scrollToCurrentHour() async {
    int currentHour = currentTime.hour;
    double itemWidth = hourDataContainerWidth;
    if (WhetherInheritedWidget.of(context)
        .whetherData
        .forecast!
        .forecastday![0]
        .hour!
        .isNotEmpty) {
      _scrollController.animateTo(
        currentHour * itemWidth * 1.1,
        duration: const Duration(seconds: 4),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WhetherData whetherData = WhetherInheritedWidget.of(context).whetherData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return (whetherData.current != null)
        ? Scaffold(
            backgroundColor: const Color.fromARGB(255, 19, 19, 19),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              centerTitle: true,
              leading: const Icon(
                Icons.menu_open_rounded,
                size: 30,
                color: Colors.white,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 23,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    whetherData.location!.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
            ),
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
                        WhetherInheritedWidget.of(context).whetherData =
                            await FeachData.feachWetherInfo(
                                await FeachLocation.determinePosition());
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
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
                                          width: 400,
                                          child: CloudAnimation(),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: height * 0.21,
                                      alignment: Alignment.center,
                                      child: WeatherConditionIcon(
                                          code: whetherData
                                              .current!.condition!.code!,
                                          isDay: whetherData.current!.isDay!),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                  ],
                                ),
                                Text(
                                  WhetherInheritedWidget.of(context)
                                      .whetherData
                                      .location!
                                      .localtime!
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
                                    (WhetherInheritedWidget.of(context)
                                                .whetherData
                                                .current!
                                                .condition!
                                                .text !=
                                            null)
                                        ? WhetherInheritedWidget.of(context)
                                            .whetherData
                                            .current!
                                            .condition!
                                            .text!
                                        : "No whether massege avaleble",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 225, 222, 222),
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
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
                                      color: Color.fromARGB(255, 241, 244, 174),
                                    ),
                                  ),
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
                                      )),
                                  Container(
                                    width: 1.6,
                                    height: 40,
                                    color: const Color.fromARGB(
                                        255, 177, 175, 175),
                                  ),
                                  otherInfoButton(
                                    label: "Rain",
                                    value: (whetherData
                                            .forecast!.forecastday!.isNotEmpty)
                                        ? "${whetherData.forecast!.forecastday![0].day!.dailyChanceOfRain}%"
                                        : "Not avalable",
                                    icon: const Icon(
                                      Icons.cloud,
                                      color: Color.fromARGB(255, 249, 249, 247),
                                    ),
                                  ),
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
                                        onPressed: () {},
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
                            Container(
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
                                sunrise: parseTime(whetherData
                                    .forecast!.forecastday![0].astro!.sunrise!),
                                sunset: parseTime(whetherData
                                    .forecast!.forecastday![0].astro!.sunset!),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
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
                            const SizedBox(
                              height: 15,
                            ),
                            Column(
                              children: List.generate(5, (index) {
                                return const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InfoWidget(
                                      lable: "Pressure",
                                      value: "10",
                                      icon: Icon(Icons.add),
                                    ),
                                    InfoWidget(
                                      lable: "Pressure",
                                      value: "10",
                                      icon: Icon(Icons.add),
                                    )
                                  ],
                                );
                              }),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Last update: ${whetherData.current!.lastUpdated!.split(" ")[0]}  |  ${whetherData.current!.lastUpdated!.split(" ")[1]}",
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 183, 182, 182),
                                          fontSize: 12),
                                    ),
                                    // const Text(
                                    //   "Team PDEVELOPMENT",
                                    //   style: TextStyle(
                                    //       color: Color.fromARGB(
                                    //           255, 200, 199, 199),
                                    //       fontSize: 12),
                                    // ),
                                  ],
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
  }) {
    return Column(
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
          style:
              const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 170, 168, 168)),
        ),
      ],
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
    WhetherData whetherData = WhetherInheritedWidget.of(context).whetherData;
    DateTime currentTime = DateTime.now();
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
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
                    isDay: whetherData
                        .forecast!.forecastday![0].hour![widget.index].isDay!)),
            Text(
              whetherData.forecast!.forecastday![0].hour![widget.index].time!
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
    );
  }
}

class InfoWidget extends StatefulWidget {
  final String lable;
  final String value;
  final Widget icon;
  const InfoWidget({
    required this.lable,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      decoration: const BoxDecoration(color: Colors.amber),
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
