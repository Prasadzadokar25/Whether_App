import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 12, 30, 1),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.24,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  165, 255, 193, 7),
                                              blurRadius: 80,
                                              spreadRadius: 18),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(200)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 90,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 13, 138, 255),
                                            blurRadius: 80,
                                            spreadRadius: 18,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(200)),
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
                            height: 250,
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
                    height: 15,
                  ),
                  const Text(
                    "Get to know your weather maps and\nradar precipitation forecast",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 222, 219, 219)),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.17,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        // Handle the button tap
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(41, 134, 255, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
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
          );
        },
      ),
    );
  }
}
