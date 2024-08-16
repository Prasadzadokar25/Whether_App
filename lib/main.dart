import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pweather/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/feach_data.dart';
import '../Controller/feach_location.dart';
import '../Model/whether_data.dart';
import '../view/landing_page.dart';
import 'Model/app_data.dart';

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

// MyApp widget
class _MyApp2State extends State {
  // WhetherData? whetherData;
  bool? isInstalled;
  bool isLocationServiceEnabled = true;
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
    _chechIsInstalled();
  }

  void _chechIsInstalled() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("isInstalled")) {
      isInstalled = prefs.getBool("isInstalled")!;
    } else {
      isInstalled = false;
    }
    setState(() {});
  }

  Future<void> _loadWeatherData() async {
    WhetherData? savedData = await FeachData.feachLocalWheatherInfo();
    if (savedData != null) {
      setState(() {
        Data.whetherData = savedData;
      });
    }
    Position? position;
    try {
      position = await FeachLocation.determinePosition();
      Data.position = position;
    } catch (e) {
      isLocationServiceEnabled = false;
    }
    try {
      WhetherData newData = await FeachData.feachWetherInfo(position!);
      setState(() {
        Data.whetherData = newData;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return (isInstalled != null)
        ? (isInstalled!)
            ? const LandingPage()
            : const SplashScreen()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}

void main() {
  runApp(const MyApp());
}
