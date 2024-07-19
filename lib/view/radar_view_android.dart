import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThermalViewPage extends StatefulWidget {
  const ThermalViewPage({super.key});

  @override
  State<ThermalViewPage> createState() => _ThermalViewPageState();
}

class _ThermalViewPageState extends State<ThermalViewPage> {
  bool isPageLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://zoom.earth/",
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
      ),
    );
  }
}
