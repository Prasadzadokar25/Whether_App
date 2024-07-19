import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/whether_data.dart';
import 'dart:convert';
import '../Model/my_data.dart';

Future<void> storeCurrentWhetherData(String value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('currentWhetherData', value);
}

class FeachData {
  static Future<WhetherData> feachWetherInfo(Position position) async {
    // Replace with your test API key
    double latitude = position.latitude;
    double longitude = position.longitude;

    String wetherApiUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=1&aqi=yes&alerts=yes";
    Uri uri = Uri.parse(wetherApiUrl);
    http.Response response = await http.get(uri);
    log(response.body);
    storeCurrentWhetherData(response.body);

    var responseData = json.decode(response.body);
    return WhetherData.fromJson(responseData);
  }

  static Future<WhetherData?> feachLocalWheatherInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("currentWhetherData")) {
      final localResponce = prefs.getString("currentWhetherData");
      var responseData = json.decode(localResponce!);
      return WhetherData.fromJson(responseData);
    }
    return null;
  }
}
