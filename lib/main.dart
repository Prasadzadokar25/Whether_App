import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wether_report_api/Controller/feach_data.dart';
import 'package:wether_report_api/Controller/feach_location.dart';
import 'package:wether_report_api/Controller/whether_inherited_widget.dart';
import 'package:wether_report_api/Model/whether_data.dart';
import 'package:wether_report_api/view/landing_page.dart';

// WeatherBlocBloc class (simulated for this example)

// MyApp widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Position>(
        future: FeachLocation.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasData) {
            return FutureBuilder<WhetherData>(
                future: FeachData.feachWetherInfo(snapshot.data!),
                builder: (context, weatherSnapshot) {
                  if (weatherSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (weatherSnapshot.hasData) {
                    return WhetherInheritedWidget(
                        whetherData: weatherSnapshot.data!,
                        child: const LandingPage());
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: Text('Failed to fetch weather data'),
                      ),
                    );
                  }
                });
          } else {
            return const Scaffold(
              body: Center(
                child: Text(
                    'This module requred your location to display data please'),
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
