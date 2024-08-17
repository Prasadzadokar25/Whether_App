import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ThermalViewPage extends StatefulWidget {
  const ThermalViewPage({super.key});

  @override
  State<ThermalViewPage> createState() => _ThermalViewPageState();
}

class _ThermalViewPageState extends State<ThermalViewPage> {
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
      return getRadarView();
    } else {
      return const Text('This platform is not supported.');
    }
  }

  Widget getRadarView() {
    return Stack(
      children: [
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "https://zoom.earth/maps/temperature/#view=19.84,72.43,5z/model=icon",
          onPageStarted: (url) {
            setState(() {
              isPageLoading = true;
            });
          },
          onPageFinished: (progress) {
            setState(() {
              isPageLoading = false;
            });
          },
        ),
        if (isPageLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        Container(
          alignment: Alignment.bottomLeft,
          width: double.infinity,
          height: 70,
          color: const Color.fromARGB(255, 252, 252, 252),
          child: const Text("   advertiment"),
        )
      ],
    );
  }
}
