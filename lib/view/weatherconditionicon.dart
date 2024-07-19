import 'package:flutter/material.dart';

class WeatherConditionIcon extends StatefulWidget {
  final int code;
  final int isDay;
  const WeatherConditionIcon(
      {required this.code, required this.isDay, super.key});

  @override
  State<WeatherConditionIcon> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WeatherConditionIcon> {
  @override
  Widget build(BuildContext context) {
    return getWeatherIcon(widget.code, widget.isDay);
  }

  Widget getWeatherIcon(int code, int isday) {
    switch (code) {
      case >= 1000 && < 1002:
        return Image.asset('assets/images/0$isday-00-clear.png');
      case >= 1003 && < 1006:
        return Image.network('assets/images/0$isday-01-partlycloudy.png');
      case >= 1006 && < 1009:
        return Image.asset('assets/images/0$isday-03-cloudy.png');
      case >= 1009 && < 1030:
        return Image.asset('assets/images/0$isday-04-overcast.png');
      case >= 1030 && < 1063:
        return Image.asset('assets/images/0$isday-02-mist.png');
      case == 1063:
        return Image.asset('assets/images/0$isday-05-patchyrain.png');
      case == 1066:
        return Image.asset('assets/images/0$isday-06-patchsnow.png');
      case == 1087:
        return Image.asset('assets/images/0$isday-08-thunder.png');
      case >= 1069 && < 1114:
        return Image.asset('assets/images/0$isday-07-patchysleet.png');
      case >= 1114 && < 1150:
        return Image.asset('assets/images/0$isday-09-fog.png');
      case >= 1150 && < 1192:
        return Image.asset('assets/images/0$isday-10-lightrain.png');
      case >= 1192 && < 1204:
        return Image.asset('assets/images/0$isday-11-heavyrain.png');
      case >= 1204 && < 1222:
        return Image.asset('assets/images/0$isday-12-lightsnow.png');
      case >= 1222 && < 1239:
        return Image.asset('assets/images/0$isday-13-heavysnow.png');
      case >= 1239 && < 1243:
        return Image.asset('assets/images/0$isday-14-lightrainshower.png');
      case >= 1243 && < 1249:
        return Image.asset('assets/images/0$isday-15-heavyrainshower.png');
      case >= 1249 && < 1264:
        return Image.asset('assets/images/0$isday-16-lightsnowshower.png');
      case == 1264:
        return Image.asset('assets/images/0$isday-17-heavysnowshawer.png');
      case == 1273:
        return Image.asset('assets/images/0$isday-19-lightrainwiththunder.png');
      case == 1276:
        return Image.asset('assets/images/0$isday-20-heavyrainwiththunder.png');
      case >= 1289 && < 1283:
        return Image.asset('assets/images/0$isday-20-heavyrainwiththunder.png');
      default:
        return Image.asset('assets/images/0$isday-21-snowwiththender.png');
    }
  }
}
