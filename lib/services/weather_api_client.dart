import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_flutter_app/models/Daily_weather_model.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class WeatherApiClient {
  Future<Weather?> getCurrentWeather(String location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=9321b085e90dad2f88d0fe8f36c1c901");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }

  Future<DailyWeather> getHourlyWeather(var lat, var long) async {
    var url2 = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&exclude=daily,minutely&units=metric&appid=9321b085e90dad2f88d0fe8f36c1c901");

    var response2 = await http.get(url2);
    var body2 = jsonDecode(response2.body);
    return DailyWeather.fromJson(body2);
  }
}
