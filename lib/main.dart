import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pweather/view/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/feach_data.dart';
import '../Controller/feach_location.dart';
import '../Controller/whether_inherited_widget.dart';
import '../Model/whether_data.dart';
import '../view/landing_page.dart';

class Starting extends StatefulWidget {
  State createState() => _StartingState();
}

class _StartingState extends State {
  @override
  Widget build(BuildContext context) {
    return MyApp2();
  }
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

// MyApp widget
class _MyApp2State extends State {
  WhetherData? whetherData;
  bool isInstalled = false;
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
    }
    setState(() {});
  }

  bool isLocationServiceEnabled = true;
  Future<void> _loadWeatherData() async {
    WhetherData? savedData = await FeachData.feachLocalWheatherInfo();
    if (savedData != null) {
      setState(() {
        whetherData = savedData;
      });
    }
    Position? position;
    try {
      position = await FeachLocation.determinePosition();
    } catch (e) {
      isLocationServiceEnabled = false;
    }
    WhetherData newData = await FeachData.feachWetherInfo(position!);
    setState(() {
      whetherData = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return whetherData != null
        ? WhetherInheritedWidget(
            whetherData: whetherData!,
            child: const LandingPage(),
          )
        : (!isLocationServiceEnabled)
            ? const Text(
                "please cheach intwork\n this module required location access",
                textAlign: TextAlign.center,
              )
            : const Center(child: CircularProgressIndicator());
  }
}

void main() {
  runApp(Starting());
}
