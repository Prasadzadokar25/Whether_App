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

  Future<void> _fetchAndCalculateSunPosition() async {
    final sunrise = widget.sunrise;
    final sunset = widget.sunset;

    final position = calculateSunPosition(sunrise, sunset);
    setState(() {
      sunPosition = position;
    });
  }

  double calculateSunPosition(DateTime sunrise, DateTime sunset) {
    final now = DateTime.now();
    final totalDaylight = sunset.difference(sunrise).inMinutes;
    final passedTime = now.difference(sunrise).inMinutes;
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
              LinearProgressIndicator(
                value: sunPosition,
                backgroundColor: Colors.blue[100],
                color: Colors.yellow,
                minHeight: 10,
              ),
              Align()
            ],
          ),
          const SizedBox(
            height: 15,
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
                    .sunrise!
                    .split(' ')[0],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSunRiseSunSetLabel({required String lable, required String time}) {
    return Column(
      children: [
        Text(
          lable,
          style: TextStyle(
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
