import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CitySearch extends StatefulWidget {
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final String apiKey = 'xmLRZRFSRzfF3YbquXZA+A==XHPKSxx4PPDiuGiq';
  final String apiUrl = 'https://api.api-ninjas.com/v1/city';

  Future<List<String>> fetchCities(String query) async {
    final response = await http.get(
      Uri.parse('$apiUrl?name=$query'),
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((city) => city['name'] as String).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios))
              ],
            ),
            TypeAheadField(
              suggestionsCallback: (pattern) async {
                return await fetchCities(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSelected: (suggestion) {
                // Do something with the selected suggestion
                print(suggestion);
              },
            ),
          ],
        ),
      ),
    );
  }
}
