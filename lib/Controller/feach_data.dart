import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:wether_report_api/Model/whether_data.dart';
import 'dart:convert';
import '../Model/my_data.dart';

class FeachData {
  static Future<WhetherData> feachWetherInfo(Position position) async {
    // Replace with your test API key
    double latitude = position.latitude;
    double longitude = position.longitude;
    String wetherApiUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=1'";
    Uri uri = Uri.parse(wetherApiUrl);
    http.Response response = await http.get(uri);
    log(response.body);
    var responseData = json.decode(response.body);
    return WhetherData.fromJson(responseData);
  }
}
