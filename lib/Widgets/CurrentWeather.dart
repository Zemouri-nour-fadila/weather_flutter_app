import 'package:flutter/material.dart';

Widget CurrentWeather(String location, String degree, String temp) {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
        height: 10.0,
      ),
      Text(location, style: const TextStyle(fontSize: 33.6)),
      const SizedBox(
        height: 10.0,
      ),
      Text(degree + '°', style: const TextStyle(fontSize: 46.6)),
      const SizedBox(
        height: 10.0,
      ),
      Text(temp,
          style: const TextStyle(
            fontSize: 25.0,
            color: Color.fromARGB(167, 2, 112, 255),
            fontWeight: FontWeight.bold,
          )),
    ],
  ));
}
