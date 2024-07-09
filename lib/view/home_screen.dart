import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:weather_app_youtube/bloc/weather_bloc_bloc.dart';

/// Copyright (c) 2024 PDevelopmet
///
/// This `HomeScreen` widget serves as the main interface for displaying weather information,
/// including current weather conditions, temperature, and additional weather details.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          'assets/images/1.png',
        );
      case >= 300 && < 400:
        return Image.asset('assets/images/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/images/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/images/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/images/5.png');
      case == 800:
        return Image.asset('assets/images/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/images/7.png');
      default:
        return Image.asset('assets/images/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        centerTitle: true,
        leading: const Icon(
          Icons.menu_open_rounded,
          size: 30,
          color: Colors.white,
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_pin,
              color: Colors.white,
              size: 23,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Pune",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 1.2 * kToolbarHeight, 30, 20),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF673AB7)),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              if (true)
                SizedBox(
                  width: width,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: width * 0.36,
                            alignment: Alignment.center,
                            child: getWeatherIcon(
                                600 /*state.weather.weatherConditionCode!*/),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "25°",
                                    //'${state.weather.temperature!.celsius!.round()}°C',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "c",
                                    //'${state.weather.temperature!.celsius!.round()}°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width * 0.64 - 25 - 60,
                                child: const Text(
                                  "Thunderclouds  ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  //	state.weather.weatherMain!.toUpperCase(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 225, 222, 222),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Center(
                                child: Text(
                                  "25/25/25",
                                  //DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(82, 44, 43, 43),
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            otherInfoButton(
                              label: "Wind",
                              value: "13 km/h",
                              icon: const Icon(
                                Icons.air_rounded,
                                color: Color.fromARGB(255, 241, 244, 174),
                              ),
                            ),
                            Container(
                              width: 1.6,
                              height: 40,
                              color: const Color.fromARGB(255, 177, 175, 175),
                            ),
                            otherInfoButton(
                                label: "Humidity",
                                value: "24%",
                                icon: const Icon(
                                  Icons.water_drop,
                                  color: Color.fromARGB(255, 122, 217, 244),
                                )),
                            Container(
                              width: 1.6,
                              height: 40,
                              color: const Color.fromARGB(255, 177, 175, 175),
                            ),
                            otherInfoButton(
                              label: "Rain",
                              value: "87%",
                              icon: const Icon(
                                Icons.water_damage_rounded,
                                color: Color.fromARGB(255, 249, 249, 247),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              'assets/images/13.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Temp Max',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "",
                                  //"${state.weather.tempMax!.celsius!.round()} °C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ]),
                          Row(children: [
                            Image.asset(
                              'assets/images/14.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Temp Min',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "25",
                                  //"${state.weather.tempMin!.celsius!.round()} °C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

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
                  color: Color.fromARGB(32, 236, 178, 3),
                  blurRadius: 10,
                )
              ],
            ),
            child: icon),
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
