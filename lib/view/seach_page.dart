import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Los Angeles',
    'Los Angeles',
    'Chicago',
    'Los Angeles',
    'Los Angeles',
    'Chicago',
    'Los Angeles',
    'Chicago',
    'Los Angeles', 'Chicago', 'Houston', 'Los Angeles', 'Chicago', 'Phoenix',
    "akot", "akola"
    // Add more cities here or fetch from an API
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(-1.2, -1.4),
            child: Container(
              height: 200,
              width: 200,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(251, 232, 151, 12)),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(0, 200, 15, 15)),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: TypeAheadField(
          //     suggestionsCallback: (pattern) {
          //       return cities
          //           .where((city) =>
          //               city.toLowerCase().startsWith(pattern.toLowerCase()))
          //           .toList();
          //     },
          //     itemBuilder: (context, suggestion) {
          //       return ListTile(
          //         title: Text(suggestion as String),
          //       );
          //     },
          //     onSelected: (suggestion) {
          //       // Do something when a city is selected
          //       print(suggestion);
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color.fromARGB(255, 243, 240, 229),
                        size: 27,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Color.fromARGB(255, 243, 240, 229),
                        size: 27,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 243, 240, 229),
                        size: 27,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 250,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 50,
                      right: 50,
                    ),
                    child: ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          autofocus: true,
                          title: Text(
                            cities[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                          hoverColor: Colors.amber,
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Divider(),
                ),
                SizedBox(
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
