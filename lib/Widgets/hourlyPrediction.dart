import 'package:flutter/material.dart';

Widget HourlyPrediction(String location, String degree, String icon) {
  return Container(
    height: 100,
    decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white))),
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            height: 300,
            color: const Color.fromARGB(255, 248, 248, 255),
            child: Card(
              color: Colors.white,
              elevation: 4,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(location, style: const TextStyle(fontSize: 10.6)),
                  const SizedBox(
                    height: 5,
                  ),
                  Image.network("http://openweathermap.org/img/w/$icon.png"),
                  Text(degree + '°', style: const TextStyle(fontSize: 10.6))
                  //Text(icon + '°', style: const TextStyle(fontSize: 10.6)),
                ],
              )),
            ),
          );
        }),
  );
}
