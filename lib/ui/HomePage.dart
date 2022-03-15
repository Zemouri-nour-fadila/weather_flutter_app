import 'package:flutter/material.dart';
import 'package:weather_flutter_app/Widgets/AditionalInfo.dart';
import 'package:weather_flutter_app/Widgets/CurrentWeather.dart';
import 'package:weather_flutter_app/Widgets/hourlyPrediction.dart';
import 'package:weather_flutter_app/services/weather_api_client.dart';
import '../models/weather_model.dart';
import '../models/Hourly_weather_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  HourlyWeather? data2;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getData() async {
    data = await client.getCurrentWeather("london", "51.5085", "-0.1257");
  }

  Future<void> getData2() async {
    data2 = await client.getHourlyWeather("51.5085", "-0.1257");
  }

  //This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 248, 255),
          elevation: 0,
          title: const Text(
            "Weather",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 248, 248, 255),
              child: IconButton(
                  color: Colors.black,
                  onPressed: () {},
                  icon: const Icon(
                    IconData(0xe33c, fontFamily: 'MaterialIcons'),
                    size: 25,
                  )),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 248, 248, 255),
              child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Location');
                  },
                  icon: const Icon(
                    IconData(0xe3dc, fontFamily: 'MaterialIcons'),
                    size: 25,
                  )),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: const Color.fromARGB(255, 248, 248, 255),
                      elevation: 4,
                      child: CurrentWeather('${data!.cityName}',
                          '${data!.degree}', '${data!.temp}')),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text("Date"),
                const SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                    future: getData2(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          children: [
                            HourlyPrediction('${data2!.hour}',
                                '${data2!.degree}', '${data2!.icon}'),
                          ],
                        );
                      }
                      return Container();
                    }),
                Column(
                  children: [
                    aditionalInfo(
                        '${data!.sunrise}',
                        '${data!.sunset}',
                        '${data!.feels_like}',
                        '${data!.wind}',
                        '${data!.humidity}',
                        '${data!.pressure}')
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
