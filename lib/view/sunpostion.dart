import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SunPositionScreen extends StatefulWidget {
  @override
  _SunPositionScreenState createState() => _SunPositionScreenState();
}

class _SunPositionScreenState extends State<SunPositionScreen> {
  double sunPosition = 0.0;
  final String apiKey =
      'eb021f5f7a9d491a9e363519240906'; // Replace with your test API key
  final double latitude = 40.7128;
  final double longitude = -74.0060;

  @override
  void initState() {
    super.initState();
    _fetchAndCalculateSunPosition();
  }

  Future<void> _fetchAndCalculateSunPosition() async {
    final sunTimes = await fetchSunTimes(apiKey, latitude, longitude);
    final sunrise = parseTime(sunTimes['sunrise']);
    final sunset = parseTime(sunTimes['sunset']);
    final position = calculateSunPosition(sunrise, sunset);
    setState(() {
      sunPosition = position;
    });
  }

  Future<Map<String, dynamic>> fetchSunTimes(
      String apiKey, double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=1'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return {
        'sunrise': data['forecast']['forecastday'][0]['astro']['sunrise'],
        'sunset': data['forecast']['forecastday'][0]['astro']['sunset'],
      };
    } else {
      throw Exception('Failed to load sun times');
    }
  }

  DateTime parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    final period = time.split(' ')[1];
    final isPM = period.toLowerCase() == 'pm';
    return DateTime(
        now.year, now.month, now.day, isPM ? hour + 12 : hour, minute);
  }

  double calculateSunPosition(DateTime sunrise, DateTime sunset) {
    final now = DateTime.now();
    final totalDaylight = sunset.difference(sunrise).inMinutes;
    final passedTime = now.difference(sunrise).inMinutes;
    return 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return SunPathWidget(sunPosition: sunPosition);
  }
}

class SunPathWidget extends StatelessWidget {
  final double sunPosition;

  SunPathWidget({required this.sunPosition});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SunPathPainter(context: context, sunPosition: sunPosition),
      size: Size(double.infinity, 200),
    );
  }
}

class SunPathPainter extends CustomPainter {
  final double sunPosition;
  BuildContext context;

  SunPathPainter({required this.context, required this.sunPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height);

    canvas.drawPath(path, paint);

    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final sunX = (MediaQuery.of(context).size.width) * sunPosition;
    final sunY = size.height * (1 - (sunPosition - 0.5).abs() * 1);

    canvas.drawCircle(Offset(sunX, sunY), 10, sunPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
