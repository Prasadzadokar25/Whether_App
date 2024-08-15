import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:pweather/Model/my_data.dart';

class CityService {
  static const String apiUrl =
      'https://wft-geo-db.p.rapidapi.com/v1/geo/cities';
  static String apiKey = MyData.apiKeyForCitys;
  static Map<String, String> headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
  };

  Future<List<Map<String, dynamic>>> fetchCityNames(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl?namePrefix=$query'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      log(response.body);
      List<dynamic> decodedData = jsonDecode(response.body)['data'];
      List<Map<String, dynamic>> cities =
          decodedData.map((e) => e as Map<String, dynamic>).toList();
      return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
