// // import "package:geolocator/geolocator.dart";
// import "package:wether_report_api/Model/locationData_model.dart";

// Future<LocationData> feachLocation() async {
//   bool locationServiceEnabled;
//   Position? position;
//   LocationData locationData =
//       LocationData(isError: false, errorMassege: "", position: position);

//   LocationPermission permisssion;
//   locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!locationServiceEnabled) {
//     locationData.isError = true;
//     locationData.errorMassege = "Loaction services are disable.";
//     return locationData;
//   }
//   permisssion = await Geolocator.checkPermission();

//   if (permisssion == LocationPermission.denied) {
//     permisssion = await Geolocator.requestPermission();
//     if (permisssion == LocationPermission.denied) {
//       locationData.isError = true;
//       locationData.errorMassege = "Loaction permissions are denied.";
//       return locationData;
//     }

//     if (permisssion == LocationPermission.deniedForever) {
//       locationData.isError = true;
//       locationData.errorMassege =
//           "Loaction permissions are permanently denied, we cannot request permission.";
//       return locationData;
//     }
//   }

//   locationData.position = await Geolocator.getCurrentPosition();
//   return locationData;
// }
