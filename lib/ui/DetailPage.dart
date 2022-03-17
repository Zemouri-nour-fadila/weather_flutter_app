import 'package:flutter/material.dart';
import 'package:weather_flutter_app/Db/database.dart';
import 'package:weather_flutter_app/Widgets/ListLocations.dart';
import 'package:weather_flutter_app/models/weather_model.dart';
import 'package:weather_flutter_app/services/shared_preferences_service.dart';
import '../services/weather_api_client.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  late Weather? _response = null;
  var listWeather;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getData(String location) async {
    data = await client.getCurrentWeather(location);
    databaseWeather w = databaseWeather();
    listWeather = w.getWeathers();
  }

  SharedPreferencesService prefs = SharedPreferencesService();

  //This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 248, 248, 255),
            foregroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "Location",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color.fromARGB(255, 248, 248, 255),
                foregroundColor: Colors.black,
                child: IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/Search');
                    },
                    icon: const Icon(
                      IconData(0xe047, fontFamily: 'MaterialIcons'),
                      size: 25,
                    )),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(7),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FutureBuilder(
                  future: getData("london"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          ListLocations(listWeather, "${data!.icon}",
                              "${data!.cityName}", "${data!.degree}")
                        ],
                      );
                    }

                    return Container();
                  }),
            ),
          ],
        ));
  }
}
