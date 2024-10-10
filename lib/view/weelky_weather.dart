import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class WeeklyReport extends StatefulWidget {
  const WeeklyReport({super.key});

  @override
  State<WeeklyReport> createState() => _WeeklyReportState();
}

class _WeeklyReportState extends State<WeeklyReport> {
  bool isPageLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(child: platformSpecificMessage());
  }

  Widget platformSpecificMessage() {
    if (kIsWeb) {
      return const Text(
        'This feature is for mobile only.',
        style: TextStyle(color: Colors.white),
      );
    } else if (Platform.isAndroid || Platform.isIOS) {
      return getWeeklyWeatherView();
    } else {
      return const Text('This platform is not supported.');
    }
  }

  Widget getWeeklyWeatherView() {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          "https://weather.com/en-IN/weather/tenday/l/360fe01f30377815aa6cfcbd472bd9908b5818ce420735bb148421f577facda7?par=samsung_widget_INS&cm_ven=L1_daily_forecast&theme=samsungDark#detailIndex2",
      onPageStarted: (url) {
        setState(() {
          isPageLoading = true;
        });
      },
      onPageFinished: (progress) {
        setState(() {
          isPageLoading = false;
        });
        // Show interstitial ad after the page finishes loading
      },
    );
  }
}
