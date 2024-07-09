import 'package:flutter/material.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 12, 30, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.21,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.24,
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
                height: 15,
              ),
              const Text(
                "Get to know your weather maps and\nradar precipitation forecast",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 222, 219, 219)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.13,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(_createRoute());
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

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LandingPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginScale = 0.8;
        const endScale = 1.0;
        const beginOpacity = 0.0;
        const endOpacity = 1.0;
        const curve = Curves.easeInCirc;

        var tweenScale = Tween<double>(begin: beginScale, end: endScale)
            .chain(CurveTween(curve: curve));
        var tweenOpacity = Tween<double>(begin: beginOpacity, end: endOpacity)
            .chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tweenOpacity),
          child: ScaleTransition(
            scale: animation.drive(tweenScale),
            child: child,
          ),
        );
      },
    );
  }
}
