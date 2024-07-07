import 'package:geolocator/geolocator.dart';

class LocationData {
  bool isError;
  String errorMassege;
  Position? position;

  LocationData({
    required this.isError,
    required this.errorMassege,
    required this.position,
  });
}
