import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

import 'sunpostion.dart';
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
      backgroundColor: Color.fromARGB(255, 19, 19, 19),
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
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 1.2 * kToolbarHeight, 25, 20),
          child: SizedBox(
            //height: height,
            child: Stack(
              children: [
                // Align(
                //   alignment: const AlignmentDirectional(3, -0.3),
                //   child: Container(
                //     height: 300,
                //     width: 300,
                //     decoration: const BoxDecoration(
                //         shape: BoxShape.circle, color: Colors.deepPurple),
                //   ),
                // ),
                // Align(
                //   alignment: const AlignmentDirectional(-3, -0.3),
                //   child: Container(
                //     height: 300,
                //     width: 300,
                //     decoration: const BoxDecoration(
                //         shape: BoxShape.circle, color: Color(0xFF673AB7)),
                //   ),
                // ),
                Align(
                  alignment: const AlignmentDirectional(0, -0.85),
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(95, 232, 217, 12)),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                if (true)
                  SingleChildScrollView(
                    child: SizedBox(
                      width: width,
                      //height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.21,
                                alignment: Alignment.center,
                                child: getWeatherIcon(
                                    100 /*state.weather.weatherConditionCode!*/),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        " 25°",
                                        //'${state.weather.temperature!.celsius!.round()}°C',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 75,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      // Text(
                                      //   "c",
                                      //   //'${state.weather.temperature!.celsius!.round()}°C',
                                      //   style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 45,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: width * 0.64 - 25 - 60,
                                    child: const Text(
                                      "Thunderclouds",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      //	state.weather.weatherMain!.toUpperCase(),
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 225, 222, 222),
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  // const Center(
                                  //   child: Text(
                                  //     "25 / june",
                                  //     //DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                                  //     style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontSize: 16,
                                  //         fontWeight: FontWeight.w400),
                                  //   ),
                                  // ),
                                ],
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
                                  color:
                                      const Color.fromARGB(255, 177, 175, 175),
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
                                  color:
                                      const Color.fromARGB(255, 177, 175, 175),
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
                          const SizedBox(height: 15),
                          Container(
                            height: 200,
                            width: width,
                            decoration: const BoxDecoration(
                                //color: Color.fromARGB(77, 50, 50, 50)
                                ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Today",
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
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
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 15,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.only(
                                              right: 16.7),
                                          height: (index == 1) ? 106 : 100,
                                          width: (index == 1) ? 72 : 67.5,
                                          decoration: (index == 1)
                                              ? const BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 4, 138, 248),
                                                      Color.fromARGB(
                                                          255, 122, 195, 255)
                                                    ],
                                                    begin:
                                                        Alignment.bottomRight,
                                                    end: Alignment.topLeft,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          119, 22, 146, 247),
                                                      blurRadius: 10,
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(26),
                                                  ),
                                                  // border: Border.all(
                                                  //   color: const Color.fromARGB(
                                                  //       255, 60, 57, 57),
                                                  // ),
                                                )
                                              : BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      50, 102, 102, 102),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(25),
                                                  ),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 60, 57, 57),
                                                  ),
                                                ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "25°",
                                                style: TextStyle(
                                                  color: (index == 1)
                                                      ? Colors.white
                                                      : const Color.fromARGB(
                                                          255, 192, 190, 190),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          53, 224, 235, 101),
                                                      blurRadius: 15,
                                                    )
                                                  ],
                                                ),
                                                child: Image.asset(
                                                  'assets/images/${index % 9 + 1}.png',
                                                  height: 30,
                                                ),
                                              ),
                                              Text(
                                                "11:00",
                                                style: TextStyle(
                                                  color: (index == 1)
                                                      ? Colors.white
                                                      : const Color.fromARGB(
                                                          255, 192, 190, 190),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(82, 44, 43, 43),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18)),
                            ),
                            alignment: Alignment.center,
                            child: SunPositionScreen(),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
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
