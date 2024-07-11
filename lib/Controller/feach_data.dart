import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/my_data.dart';

class FeachData {
  static Future<Map> feachWetherInfo() async {
    // Replace with your test API key
    const double latitude = 18.5204;
    const double longitude = 73.8567;
    String wetherApiUrl =
        "https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$latitude,$longitude&days=1'";
    Uri uri = Uri.parse(wetherApiUrl);
    http.Response response = await http.get(uri);
    log(response.body);
    var responseData = json.decode(response.body);
    return responseData;
  }
}
