import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wether_report_api/view/splash_screen.dart';
import 'Model/whether_data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WhetherInheritedWidget(
        key: key,
        whetherData: WhetherData(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}

// ignore: must_be_immutable
class WhetherInheritedWidget extends InheritedWidget {
  WhetherData whetherData;
  WhetherInheritedWidget({
    super.key,
    required super.child,
    required this.whetherData,
  });

  @override
  bool updateShouldNotify(WhetherInheritedWidget oldWidget) {
    log("in chang notifire");
    log("${whetherData != oldWidget.whetherData}");
    return whetherData != oldWidget.whetherData;
  }

  static WhetherInheritedWidget of(context) {
    return context
        .dependOnInheritedWidgetOfExactType<WhetherInheritedWidget>()!;
  }
}
