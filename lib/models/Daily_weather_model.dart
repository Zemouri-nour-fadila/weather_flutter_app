import 'package:intl/intl.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class DailyWeather {
  var icon;
  var hour;
  var degree;
  late List<dynamic> hourly;

  DailyWeather({this.icon, this.degree, this.hour, this.hourly = const []});

  DailyWeather.fromJson(Map<String, dynamic> json) {
    icon = json["current"]["weather"][0]["icon"];
    hour = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
        DateTime.fromMillisecondsSinceEpoch(json["current"]["dt"] * 1000,
                isUtc: true)
            .toString()
            .replaceAll(".", " ")
            .split(' ')[1]));
    degree = json["current"]["temp"];
    hourly = json['hourly']
        .map((item) => HourlyWeather.fromJson(item))
        .toList()
        .skip(1)
        .take(24)
        .toList();
  }
}

class HourlyWeather {
  var icon;
  var hour;
  var degree;
  HourlyWeather({this.icon, this.degree, this.hour});

  HourlyWeather.fromJson(Map<String, dynamic> json) {
    icon = json["weather"][0]["icon"];
    degree = json["temp"];
    hour = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
        DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000, isUtc: true)
            .toString()
            .replaceAll(".", " ")
            .split(' ')[1]));
  }
}
