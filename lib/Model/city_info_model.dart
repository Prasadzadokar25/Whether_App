import 'package:pweather/Model/whether_data.dart';

class Citys {
  List<City>? citys;

  Citys({this.citys});

  Citys.fromJson(Map<dynamic, dynamic> json) {
    if (json['citys'] != null) {
      citys = <City>[];
      json['citys'].forEach((v) {
        citys!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (citys != null) {
      data['citys'] = citys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? name;
  WhetherData? weather;

  City({this.name, this.weather});

  City.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weather =
        json['weather'] != null ? WhetherData.fromJson(json['weather']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    return data;
  }
}
