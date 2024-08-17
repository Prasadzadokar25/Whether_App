import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pweather/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/feach_data.dart';
import '../Controller/feach_location.dart';
import '../Model/whether_data.dart';
import '../view/landing_page.dart';
import 'Model/app_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp2(),
      title: "PWeather",
    );
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  bool? isInstalled;

  @override
  void initState() {
    super.initState();
    checkInstalled();
  }

  void checkInstalled() async {
    isInstalled = await _checkIsInstalled();
    // Trigger a rebuild after the async operation
    setState(() {});
    if (isInstalled == true) {
      _loadWeatherData();
    }
    setState(() {});
  }

  Future<bool> _checkIsInstalled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey("isInstalled");
  }

  Future<void> _loadWeatherData() async {
    try {
      WhetherData? savedData = await FeachData.feachLocalWheatherInfo();
      if (savedData != null) {
        setState(() {
          Data.whetherData = savedData;
        });
      }

      Position? position = await FeachLocation.determinePosition();
      Data.position = position;

      WhetherData newData = await FeachData.feachWetherInfo(position);
      setState(() {
        Data.whetherData = newData;
      });
    } catch (e) {
      log("Error loading weather data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isInstalled != null)
        ? (isInstalled == true)
            ? const LandingPage()
            : const SplashScreen()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
