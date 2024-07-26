import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../Controller/feach_data.dart';
import '../Controller/feach_location.dart';
import '../Controller/whether_inherited_widget.dart';
import '../Model/whether_data.dart';
import '../view/landing_page.dart';
import '../view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp2(),
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
  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  bool isLocationServiceEnabled = true;
  Future<void> _loadWeatherData() async {
    WhetherData? savedData = await FeachData.feachLocalWheatherInfo();
    setState(() {
      whetherData = savedData;
    });
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
            ? Text("please cheach intwork")
            : const Center(child: CircularProgressIndicator());
  }
}

void main() {
  runApp(const MyApp());
}
