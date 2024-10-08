import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pweather/Model/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/city_service.dart';
import '../Controller/feach_location.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key});

  @override
  State createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearch> {
  final CityService _cityService = CityService();
  final TextEditingController textEditingController = TextEditingController();
  bool isMapShowed = true;
  List<Map<String, dynamic>>? options;
  Map<String, dynamic>? currentSelectedCity;
  bool iscityPopUpShowed = false;

  double? currentLatitude = 18.519574;
  double? currentLongitude = 73.855287;

  @override
  void initState() {
    super.initState();
    feachUserLocation();
  }

  void feachUserLocation() async {
    currentLatitude = Data.position!.latitude;
    currentLongitude = Data.position!.longitude;
    setState(() {});
    Data.position = await FeachLocation.determinePosition();
    currentLatitude = Data.position!.latitude;
    currentLongitude = Data.position!.longitude;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                TextField(
                  onChanged: (value) async {
                    options = await _cityService
                        .fetchCityNames(textEditingController.text);
                    setState(() {
                      if (textEditingController.text.isEmpty ||
                          textEditingController.text == "") {
                        isMapShowed = true;
                      } else {
                        isMapShowed = false;
                      }
                    });
                  },

                  style: const TextStyle(color: Colors.white),
                  controller: textEditingController,
                  // onEditingComplete: onFieldSubmitted,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 45,
                      maxWidth: screenWidth * 0.72,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 213, 213, 213),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        textEditingController.clear();
                        isMapShowed = true;
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 201, 201, 201),
                        size: 18,
                      ),
                    ),
                    hintText: 'Search city...',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(131, 248, 248, 248),
                      fontSize: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 61, 61, 61),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        currentLatitude = Data.position!.latitude;
                        currentLongitude = Data.position!.longitude;
                      });
                    },
                    icon: const Icon(Icons.my_location_rounded))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Expanded(
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: const Color.fromARGB(255, 23, 23, 23),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        child: (!isMapShowed)
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: options!.length,
                                  itemBuilder: (context, index) {
                                    final Map<String, dynamic> option =
                                        options!.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        textEditingController.text =
                                            option['name'];
                                        currentLatitude = option['latitude'];
                                        currentLongitude = option['longitude'];
                                        currentSelectedCity = option;
                                        iscityPopUpShowed = true;

                                        setState(() {
                                          isMapShowed = true;
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  option['name'] ??
                                                      'Unknown City',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  "${option['region'] ?? 'Unknown Region'}, ${option['country'] ?? 'Unknown country'}",
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 170, 170, 170),
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 0.3,
                                            color: Color.fromARGB(
                                                255, 152, 152, 152),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: (Data.position != null &&
                                        currentLatitude != null &&
                                        currentLongitude != null)
                                    ? Stack(
                                        children: [
                                          MapSample(
                                            currentLatitude: currentLatitude!,
                                            currentLongitude: currentLongitude!,
                                          ),
                                          if (iscityPopUpShowed)
                                            Positioned(
                                              top: screenHeight * 0.61,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  cityPopUp(
                                                      cityDetails:
                                                          currentSelectedCity!,
                                                      context: context),
                                                ],
                                              ),
                                            )
                                        ],
                                      )
                                    : const CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cityPopUp(
      {required Map<String, dynamic> cityDetails,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: MediaQuery.of(context).size.width * 0.80,
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    cityDetails["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      "${cityDetails['region'] ?? 'Unknown Region'}, ${cityDetails['country'] ?? 'Unknown country'}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 170, 170, 170),
                          fontSize: 13),
                    ),
                  ),
                  Text(
                    DateTime.now().toString().substring(0, 16),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 13),
                  ),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "26°",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 251, 251),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "30°/23°",
                    style: TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 13),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      iscityPopUpShowed = false;
                    });
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
              TextButton(
                  onPressed: () async {
                    addCityInLocalStorage(cityDetails: cityDetails);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void addCityInLocalStorage(
      {required Map<String, dynamic> cityDetails}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("citys")) {
      String? localCityDataInString = prefs.getString("citys");
      Map data = jsonDecode(localCityDataInString!);
      data["citys"].add(cityDetails);
      prefs.setString("citys", jsonEncode(data));
      log(jsonEncode(data));
    } else {
      List cites = [cityDetails];
      Map data = {"citys": cites};
      prefs.setString("citys", jsonEncode(data));

      log(jsonEncode(data));
    }
  }
}

class MapSample extends StatelessWidget {
  final double currentLatitude;
  final double currentLongitude;
  const MapSample(
      {super.key,
      required this.currentLatitude,
      required this.currentLongitude});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(currentLatitude, currentLongitude),
        initialZoom: 8.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
          //   tileProvider: CachedNetworkTileProvider(),
          additionalOptions: const {
            'attribution': '© OpenStreetMap contributors',
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(currentLatitude, currentLongitude),
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
