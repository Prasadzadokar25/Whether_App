import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wether_report_api/Controller/feach_data.dart';
import 'package:wether_report_api/Controller/feach_location.dart';
import 'package:wether_report_api/Model/locationData_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var wetherReport;
  LocationData? locationData;

  @override
  void initState() {
    super.initState();
    //  feach_location();
    feach_data();
  }

  void feach_location() async {
    //locationData = await feachLocation();
    log("wetherReport: ${locationData!.position!.latitude}");
  }

  void feach_data() async {
    wetherReport = await FeachData.feachWetherInfo(location: "Akot");
    print(wetherReport);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Wether Report"),
        centerTitle: true,
      ),
    );
  }
}
