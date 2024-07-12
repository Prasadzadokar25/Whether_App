import 'package:flutter/material.dart';
import 'package:wether_report_api/view/home_screen.dart';
import 'package:wether_report_api/view/seach_page.dart';
import 'package:wether_report_api/view/thermal_view_page.dart';
import 'navigation_bar.dart';
import 'setting_page.dart';

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
    const SearchPage(),
    const ThermalViewPage(),
    const SettingPage(),
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   _fetchWeatherData();
  // }

  // Future<void> _fetchWeatherData() async {
  //   final whetherData = await FeachData.feachWetherInfo();
  //   setState(() {
  //     WhetherInheritedWidget.of(context).whetherData =
  //         WhetherData.fromJson(whetherData);

  //     log("${WhetherInheritedWidget.of(context).whetherData.toJson()['current']['temp_c']}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
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
              icon: const Icon(Icons.search),
              title: const Text('Search'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.event),
              title: const Text('Thermal'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Setting'),
            ),
          ],
        ),
      ),
    );
  }
}
