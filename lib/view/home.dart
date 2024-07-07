import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wether_report_api/Controller/feach_data.dart';
//import 'package:wether_report_api/Controller/feach_location.dart';
import 'package:wether_report_api/Model/locationData_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var wetherReport;
  // LocationData? locationData;

  @override
  void initState() {
    super.initState();
    //  feach_location();
    feach_data();
  }

  void feach_location() async {
    //locationData = await feachLocation();
    // log("wetherReport: ${locationData!.position!.latitude}");
  }

  void feach_data() async {
    wetherReport = await FeachData.feachWetherInfo(location: "Akot");
    print(wetherReport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   title: const Text("Wether Report"),
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 191, 0),
            Color.fromARGB(255, 226, 166, 54),
            Color.fromARGB(255, 72, 97, 237),
            Color.fromARGB(255, 93, 93, 125),
            Color.fromARGB(255, 25, 25, 25),
            Color.fromARGB(255, 3, 3, 3),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}
