// ignore: must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import '../Model/whether_data.dart';

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
