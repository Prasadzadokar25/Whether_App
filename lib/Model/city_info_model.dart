import 'package:pweather/Model/whether_data.dart';

class Citys {
  List<City>? citys;

  Citys({this.citys});

  Citys.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      citys = <City>[];
      json['data'].forEach((v) {
        citys!.add(City.fromJson(v));
      });
    }
  }
}

class City {
  int? id;
  String? wikiDataId;
  String? type;
  String? city;
  String? name;
  String? country;
  String? countryCode;
  String? region;
  String? regionCode;
  String? regionWdId;
  double? latitude;
  double? longitude;
  int? population;
  WhetherData? weather;

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    wikiDataId = json['wikiDataId'];
    type = json['type'];
    city = json['city'];
    country = json["country"];
    countryCode = json["countryCode"];
    region = json["region"];
    regionCode = json["regionCode"];
    regionWdId = json["regionWdId"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    population = json["population"];
    weather =
        json['weather'] != null ? WhetherData.fromJson(json['weather']) : null;
  }
}
