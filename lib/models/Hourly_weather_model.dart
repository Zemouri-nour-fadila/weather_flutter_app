import 'package:intl/intl.dart';

class HourlyWeather {
  var lat;
  var long;
  var icon;
  var hour;
  var degree;
  var dt;

  HourlyWeather(
      {this.dt, this.icon, this.degree, this.lat, this.long, this.hour});

  HourlyWeather.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    long = json["lon"];
    icon = json["current"]["weather"][0]["icon"];
    hour = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
        DateTime.fromMillisecondsSinceEpoch(json["current"]["dt"] * 1000,
                isUtc: true)
            .toString()
            .replaceAll(".", " ")
            .split(' ')[1]));
    degree = json["current"]["temp"];
    //lat = json["hourly"]["dt"];
  }
}
