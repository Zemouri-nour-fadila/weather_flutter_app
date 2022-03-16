import 'package:intl/intl.dart';

class Weather {
  var icon;
  var cityName;
  var lat;
  var long;
  var temp; //main -> clouds
  var degree; //temp
  var wind;
  var code;
  var sunrise;
  var sunset;
  var humidity;
  var feels_like;
  var pressure;
  var date;
  var temp24Hour = [];

  Weather(
      {this.cityName,
      this.code,
      this.icon,
      this.sunrise,
      this.sunset,
      this.temp,
      this.degree,
      this.wind,
      this.humidity,
      this.feels_like,
      this.pressure,
      this.lat,
      this.long,
      this.date});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    icon = json["weather"][0]["icon"];
    temp = json["weather"][0]["main"];
    degree = json["main"]["temp"];
    wind = json["wind"]["speed"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    sunset = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
        DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunset"] * 1000,
                isUtc: true)
            .toString()
            .replaceAll(".", " ")
            .split(' ')[1]));
    lat = json["coord"]["lat"];
    long = json["coord"]["lon"];

    sunrise = DateFormat.jm().format(DateFormat("hh:mm:ss").parse(
        DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunrise"] * 1000,
                isUtc: true)
            .toString()
            .replaceAll(".", " ")
            .split(' ')[1]));
    date = DateFormat('EEEE').format(DateTime.parse(
            DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunrise"] * 1000,
                    isUtc: true)
                .toString())) +
        '-' +
        DateFormat('dd.MM.yy').format(DateTime.parse(
            DateTime.fromMillisecondsSinceEpoch(json["sys"]["sunrise"] * 1000,
                    isUtc: true)
                .toString()
                .split(' ')[0]));
  }
}
