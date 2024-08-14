import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pweather/Model/my_data.dart';
import 'package:pweather/view/new_city_weather.dart';
import 'package:pweather/view/weatherconditionicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controller/whether_inherited_widget.dart';
import '../Model/city_info_model.dart';
import '../Model/whether_data.dart';
import '../view/home_screen.dart';
import '../view/radar_view_android.dart';
import 'navigation_bar.dart';
import 'setting_page.dart';
import 'dart:convert';
// import 'package:url_launcher/url_launcher.dart';

/// Copyright (c) 2024 PDevelopment
///
/// This `LandingPage` widget serves as the main navigation interface,
/// allowing users to switween different sections of the app using
/// a bottom navigation bar. It includes the following features:
///
/// - Stateful Widget: Maintains its state and updates its UI dynamically.
/// - Pages: Contains a list of different pages (Home, Search, Thermal View).
/// - Selected Index: Keeps track of the currently selected tab.
/// - Bottom Navigation Bar: Uses `FlashyTabBar` for navigation with four items (Home, Search, Events, Settings).
/// - UI Customization: Customizes the `Scaffold` widget's background color and body extension.

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const SettingPage(),
    const ThermalViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    WhetherData whetherData = WhetherInheritedWidget.of(context).whetherData;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: MyDrawer(),
      ),
      appBar: (_selectedIndex == 0)
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark),
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 23,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    whetherData.location!.name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5.7),
        child: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.event),
              title: const Text('10 days'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.satellite_alt),
              title: const Text('Radar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Citys? citys = Citys.fromJson({"citys": []});
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    citys = await feactCitysFromLocalStorage();
    setState(() {});
  }

  Future<Citys?> feactCitysFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // prefs.setString("citys",
    //     '{"citys":[{"name":"pune","weather":{}},{"name":"mumbai","weather":{}},{"name":"akola","weather":{}}]}');

    if (prefs.containsKey("citys")) {
      String? citysString = prefs.getString("citys");
      Map<dynamic, dynamic> citysMap = jsonDecode(citysString!);
      return Citys.fromJson(citysMap);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    WhetherData whetherData = WhetherInheritedWidget.of(context).whetherData;

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: TypeAheadField(
        //     suggestionsCallback: (pattern) {
        //       return cities
        //           .where((city) =>
        //               city.toLowerCase().startsWith(pattern.toLowerCase()))
        //           .toList();
        //     },
        //     itemBuilder: (context, suggestion) {
        //       return ListTile(
        //         title: Text(suggestion as String),
        //       );
        //     },
        //     onSelected: (suggestion) {
        //       // Do something when a city is selected
        //       print(suggestion);
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 26, right: 18, left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    color: const Color.fromARGB(255, 243, 242, 242),
                    onPressed: () {
                      navigateToCitySearchPage();
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Color.fromARGB(255, 243, 240, 229),
                      size: 27,
                    ),
                  ),
                  IconButton(
                    color: const Color.fromARGB(255, 243, 242, 242),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.settings,
                      color: Color.fromARGB(255, 243, 240, 229),
                      size: 27,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 160,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 5,
                    right: 5,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(
                            citys!.citys!.length,
                            (index) {
                              City city = citys!.citys![index];
                              return ListTile(
                                title: Text(
                                  city.name!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14.5),
                                ),
                                trailing: SizedBox(
                                  height: 24,
                                  width: 55,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      WeatherConditionIcon(
                                        code: whetherData
                                            .current!.condition!.code!,
                                        isDay: whetherData.current!.isDay!,
                                      ),
                                      const Text(
                                        "25",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.5),
                                      )
                                    ],
                                  ),
                                ),
                                leading: const Icon(Icons.location_on_sharp),
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Divider(),
                        ),
                        ListTile(
                          onTap: () {
                            final Uri feedbackUri = Uri(
                              scheme: 'mailto',
                              path: 'pnews.prasadzadokar@gmail.com',
                              queryParameters: {
                                'subject':
                                    'Reporting wrong location in PWeather'
                              },
                            );
                            _launchUrl(feedbackUri.toString());
                          },
                          title: const Text(
                            "Report wrong location",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          leading: const Icon(
                            Icons.error_outline_outlined,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    getSocialMediaButton(
                        iconyurl: "assets/images/linkdin_logo.png",
                        launchUrl:
                            "https://www.linkedin.com/in/prasad-zadokar?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"),
                    const SizedBox(
                      width: 20,
                    ),
                    getSocialMediaButton(
                        iconyurl: "assets/images/insta_logo.jpg",
                        launchUrl:
                            "https://www.instagram.com/_prasadpatil.?igsh=MTV5ZXF1bnVsdjlkZA=="),
                    const SizedBox(
                      width: 20,
                    ),
                    getSocialMediaButton(
                        iconyurl: "assets/images/yt_logo.png",
                        launchUrl:
                            "https://www.youtube.com/channel/UCQRjYSyYW-8Pl9P1zX9RSRw"),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void navigateToCitySearchPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CitySearch();
    }));
  }

  Widget getSocialMediaButton({required String iconyurl, required launchUrl}) {
    return GestureDetector(
      onTap: () {
        _launchUrl(launchUrl);
      },
      child: Container(
        height: 36,
        width: 36,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0), shape: BoxShape.circle),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Image.asset(iconyurl)),
      ),
    );
  }
}

void _launchUrl(String url) async {
  const fallbackUrl = MyData.linkdinUrl;

  try {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } catch (e) {
    await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
  }
}
