import 'package:http/http.dart' as http;
import 'dart:convert';

class FeachData {
  static Future<Map> feachWetherInfo({required String location}) async {
    String wetherApiUrl =
        "http://api.weatherapi.com/v1/current.json?key=eb021f5f7a9d491a9e363519240906&q=$location&aqi=no";
    Uri uri = Uri.parse(wetherApiUrl);
    http.Response response = await http.get(uri);
    var responseData = json.decode(response.body);
    return responseData;
  }
}
