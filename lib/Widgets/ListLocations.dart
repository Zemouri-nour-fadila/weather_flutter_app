import 'package:flutter/material.dart';
import 'package:weather_flutter_app/Db/database.dart';

Widget ListLocations(
    var listWeather, String icon, String cityName, String degree) {
  return Container(
    height: 500,
    decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.white),
            bottom: BorderSide(color: Colors.white))),
    child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            color: const Color.fromARGB(255, 248, 248, 255),
            child: Card(
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  leading: Image.network(
                      "http://openweathermap.org/img/w/$icon.png"),
                  trailing: Container(
                    width: 135,
                    child: Row(
                      children: <Widget>[
                        Text(degree + '°',
                            style: const TextStyle(fontSize: 30.0)),
                        const SizedBox(height: 50),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            databaseWeather db = databaseWeather();
                            print(await db.getWeathers());
                          },
                        ),
                      ],
                    ),
                  ),
                  title: Text(cityName, style: const TextStyle(fontSize: 10.6)),
                  subtitle: Text(cityName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                )),
          );
        }),
  );
}
