import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_flutter_app/models/Hourly_weather_model.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String location, var lat, var long) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&lat=$lat&lon=$long&units=metric&appid=9321b085e90dad2f88d0fe8f36c1c901");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    // ignore: avoid_print
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }

  Future<HourlyWeather?>? getHourlyWeather(var lat, var long) async {
    var url2 = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=51.5085&lon=-0.1257&exclude=daily,minutely,hourly&units=metric&appid=9321b085e90dad2f88d0fe8f36c1c901");

    var response2 = await http.get(url2);
    print(url2);
    var body2 = jsonDecode(response2.body);
    //print("hours" + HourlyWeather.fromJson(body2).hour);
    return HourlyWeather.fromJson(body2);
  }
}
