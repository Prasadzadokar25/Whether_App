import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wether_report_api/main.dart';

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
      log("${position}");
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    height: 25,
                    width: MediaQuery.of(context).size.width - 100 - 25,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 100 - 5 - 20) *
                        sunPosition,
                  ),
                  Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 249, 86, 4),
                            Color.fromARGB(255, 249, 176, 140),
                            Color.fromARGB(255, 255, 255, 255)
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        boxShadow: [
                          if (sunPosition < 0.91)
                            const BoxShadow(
                              color: Color.fromARGB(255, 255, 173, 41),
                              blurRadius: 16,
                              spreadRadius: 1,
                            )
                        ]),
                  ),
                  // const Icon(
                  //   Icons.sunny,
                  //   size: 25,
                  //   color: Color.fromARGB(255, 255, 168, 7),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 25,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 25, 25, 25),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 25, 25, 25),
                            blurRadius: 5,
                            spreadRadius: 2,
                          )
                        ]),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getSunRiseSunSetLabel(
                lable: "Sunrise",
                time: WhetherInheritedWidget.of(context)
                    .whetherData
                    .forecast!
                    .forecastday![0]
                    .astro!
                    .sunrise!
                    .split(' ')[0],
              ),
              getSunRiseSunSetLabel(
                lable: "Sunset",
                time: WhetherInheritedWidget.of(context)
                    .whetherData
                    .forecast!
                    .forecastday![0]
                    .astro!
                    .sunset!,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String convertInto24Hour(String time) {
    if (time.endsWith("PM") || time.endsWith('pm')) {
      String newTime = time.replaceAll("pm", "");
      String newTime2 = newTime.replaceAll("PM", "");
      List<String> parts = newTime2.split(":");
      int hour = int.parse(parts[0]) + 12;
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
}
