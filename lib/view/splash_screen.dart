import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/feach_data.dart';
import '../Controller/feach_location.dart';
import '../Model/app_data.dart';
import '../Model/whether_data.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLocationServiceEnabled = true;

  @override
  void initState() {
    super.initState();
    determinePosition();
    _loadWeatherData();
  }

  Future<bool> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showLocationErrorDialog("Location services are not enabled");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showLocationErrorDialog("Location permissions are denied");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showLocationErrorDialog(
          "Location permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 12, 30, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.22,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(218, 255, 193, 7),
                                          blurRadius: 80,
                                          spreadRadius: 18),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 90,
                                ),
                                Container(
                                  height: height * 0.06,
                                  width: height * 0.06,
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 4, 112, 254),
                                        blurRadius: 80,
                                        spreadRadius: 18,
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/cloud1.png",
                        height: 270,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "Discover the Weather\nin your city",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 13,
              ),
              const Text(
                "Get to know your weather maps and\nradar precipitation forecast",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 222, 219, 219)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.11,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    if (await determinePosition()) {
                      navigateToLandingPage();
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isInstalled", true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Color.fromARGB(238, 255, 176, 139),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Please enable Location permission",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 54, 54, 54)),
                              ),
                            ],
                          ),
                        ),
                      );
                      _loadWeatherData();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: height * 0.06,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(41, 134, 255, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLandingPage() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const LandingPage();
        },
      ),
    );
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
      isLocationServiceEnabled = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("citys",
          '{"citys":[{"id":1,"wikiDataId":"1","type":"CITY","userlocation":"My Location","name":"My Location","country":"na","countryCode":"na","region":"na","regionCode":"na","regionWdId":"1","latitude":${position.latitude},"longitude":${position.longitude},"population":0}]}');
      setState(() {});
    } catch (e) {
      isLocationServiceEnabled = false;
      showLocationErrorDialog(e.toString());
    }

    try {
      WhetherData newData = await FeachData.feachWetherInfo(position!);
      setState(() {
        Data.whetherData = newData;
      });
    } catch (e) {
      log("$e");
    }
  }

  void showLocationErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        String message = "An error occurred while fetching location.";
        if (errorMessage.contains('Location services are disabled')) {
          message = "Please enable location services.";
        } else if (errorMessage.contains('Location permissions are denied')) {
          message = "Location permissions are denied. Please enable them.";
        } else if (errorMessage
            .contains('Location permissions are permanently denied')) {
          message =
              "Location permissions are permanently denied. Please enable them in the app settings.";
        }

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Geolocator.openAppSettings();
                    },
                    child: const Text(
                      "Open settings",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
