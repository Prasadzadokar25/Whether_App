import 'package:flutter/material.dart';
import '../Controller/whether_inherited_widget.dart';
import '../Model/imagepaths.dart';


class SunPositionScreen extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;
  const SunPositionScreen(
      {required this.sunrise, required this.sunset, super.key});

  @override
  State createState() => _SunPositionScreenState();
}

class _SunPositionScreenState extends State<SunPositionScreen> {
  double sunPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchAndCalculateSunPosition();
  }

  void _fetchAndCalculateSunPosition() {
    final sunrise = widget.sunrise;
    final sunset = widget.sunset;

    final position = calculateSunPosition(sunrise, sunset);
    setState(() {
      sunPosition = position;
    });
  }

  double calculateSunPosition(DateTime sunrise, DateTime sunset) {
    print(sunrise.toString());
    print(sunset.toString());
    final now = DateTime.now();
    final totalDaylight = sunset.difference(sunrise).inMinutes;
    final passedTime = now.difference(sunrise).inMinutes;
    if (passedTime / totalDaylight >= 1) {
      return 1;
    }
    return passedTime / totalDaylight;
  }

  @override
  Widget build(BuildContext context) {
    List sunriseStringPart = widget.sunrise.toString().split(" ")[1].split(":");
    List sunsetStringPart = widget.sunset.toString().split(" ")[1].split(":");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 70 - 25,
                    alignment: Alignment.center,
                    child: LinearProgressIndicator(
                      value: sunPosition,
                      backgroundColor: const Color.fromARGB(255, 162, 211, 251),
                      color: Colors.yellow,
                      minHeight: 6,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
              if (sunPosition >= 0 && sunPosition < 1)
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:
                            (MediaQuery.of(context).size.width - 70 - 5 - 25) *
                                sunPosition,
                      ),
                      GestureDetector(
                        onLongPress: () {},
                        child: Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 252, 46, 27),
                                  Color.fromARGB(255, 251, 157, 118),
                                  Color.fromARGB(255, 255, 233, 233)
                                ],
                                // stops: [0.2, 0.8, 0.9],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                              boxShadow: [
                                if (sunPosition < 0.91 && sunPosition > 0.085)
                                  const BoxShadow(
                                    color: Color.fromARGB(255, 255, 173, 41),
                                    blurRadius: 16,
                                    spreadRadius: 1,
                                  )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       height: 40,
              //       width: 30,
              //       decoration: const BoxDecoration(
              //         boxShadow: [],
              //       ),
              //       child: Image.asset(
              //         "assets/images/mountains.png",
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     Container(
              //       height: 30,
              //       width: 25,
              //       decoration: const BoxDecoration(
              //           color: Color.fromARGB(255, 25, 25, 25),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Color.fromARGB(255, 25, 25, 25),
              //               blurRadius: 5,
              //               spreadRadius: 2,
              //             )
              //           ]),
              //     )
              //   ],
              // )
            ],
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSunRiseSunSetLabel(
                lable: "Sunrise",
                time: sunriseStringPart[0] + ":" + sunriseStringPart[1],
              ),
              getSunRiseSunSetLabel(
                lable: "Sunset",
                time: sunsetStringPart[0] + ":" + sunsetStringPart[1],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MoonLocation extends StatefulWidget {
  const MoonLocation({super.key});

  @override
  State<MoonLocation> createState() => _MoonLocationState();
}

class _MoonLocationState extends State<MoonLocation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSunRiseSunSetLabel(
                lable: "Moonrise",
                time: WhetherInheritedWidget.of(context)
                    .whetherData
                    .forecast!
                    .forecastday![0]
                    .astro!
                    .moonrise!,
              ),
              Column(
                children: [
                  Image.asset(
                    Paths.moon,
                    height: 55,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    WhetherInheritedWidget.of(context)
                        .whetherData
                        .forecast!
                        .forecastday![0]
                        .astro!
                        .moonPhase!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 229, 228, 228),
                    ),
                  )
                ],
              ),
              getSunRiseSunSetLabel(
                lable: "Moonset",
                time: WhetherInheritedWidget.of(context)
                    .whetherData
                    .forecast!
                    .forecastday![0]
                    .astro!
                    .moonset!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String convertInto24Hour(String time) {
  if (time.endsWith("PM") || time.endsWith('pm')) {
    String newTime = time.replaceAll("pm", "");
    String newTime2 = newTime.replaceAll("PM", "");
    List<String> parts = newTime2.split(":");
    int hour = (int.parse(parts[0]) + 12) % 24;

    return "$hour:${parts[1]}";
  } else if (time.endsWith("AM") || time.endsWith('am')) {
    String newTime = time.replaceAll("AM", "");
    String newTime2 = newTime.replaceAll("am", "");

    return newTime2;
  }
  return time;
}

Widget getSunRiseSunSetLabel({required String lable, required String time}) {
  time = convertInto24Hour(time);
  return Column(
    children: [
      Text(
        lable,
        style: const TextStyle(
          color: Color.fromARGB(255, 140, 139, 139),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.7,
          fontSize: 12,
        ),
      ),
      Text(
        time,
        style: const TextStyle(
          color: Color.fromARGB(255, 245, 247, 248),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.7,
          fontSize: 18,
        ),
      ),
    ],
  );
}
