import 'package:flutter/material.dart';
import '../Controller/city_service.dart';

class CitySearch extends StatefulWidget {
  const CitySearch({super.key});

  @override
  State createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearch> {
  final CityService _cityService = CityService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Autocomplete<Map<String, dynamic>>(
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<Map<String, dynamic>>.empty();
            } else {
              return await _cityService.fetchCityNames(textEditingValue.text);
            }
          },
          onSelected: (Map<String, dynamic> selection) {
            // Handle the selected city map
            print('Selected: ${selection['name']}');
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    title: Text("prasad"),
                  );
                });
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onEditingComplete: onFieldSubmitted,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(
                      maxHeight: 45,
                      maxWidth: screenWidth * 0.80,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 213, 213, 213),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        textEditingController.clear();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 201, 201, 201),
                        size: 18,
                      ),
                    ),
                    hintText: 'Search city...',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(216, 248, 248, 248),
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
              ],
            );
          },
          optionsViewBuilder: (
            BuildContext context,
            AutocompleteOnSelected<Map<String, dynamic>> onSelected,
            Iterable<Map<String, dynamic>> options,
          ) {
            return Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: const Color.fromARGB(255, 23, 23, 23),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> option =
                                options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          option['name'] ?? 'Unknown City',
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
                                    color: Color.fromARGB(255, 152, 152, 152),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
