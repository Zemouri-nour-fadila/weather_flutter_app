import 'package:flutter/material.dart';
import 'package:weather_flutter_app/Db/database.dart';
import 'package:weather_flutter_app/models/weather_model.dart';
import 'package:weather_flutter_app/models/weathermodel.dart';
import 'package:weather_flutter_app/services/shared_preferences_service.dart';
import 'package:weather_flutter_app/services/weather_api_client.dart';
import 'package:weather_flutter_app/ui/DetailPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final TextEditingController cityController = TextEditingController();
  final client = WeatherApiClient();
  late Weather? _response = null;

  @override
  void initState() {
    super.initState();
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
            foregroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "Search",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Form(
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                        suffixIcon: Column(
                          children: [
                            GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  cityController.text = '';
                                }),
                            GestureDetector(
                                child: const Icon(Icons.search),
                                onTap: () {
                                  getCityname();
                                }),
                          ],
                        ),
                        labelText: 'Enter a city name',
                        hintText: 'Example: london'),
                  ),
                ))
              ]),
            ),
            if (_response != null)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      color: const Color.fromARGB(255, 248, 248, 255),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.network(
                                  "http://openweathermap.org/img/w/${_response!.icon}.png"),
                              trailing: Text(
                                '${_response!.degree}??',
                                style: const TextStyle(fontSize: 30.0),
                              ),
                              title: Text('${_response!.cityName}',
                                  style: const TextStyle(color: Colors.black)),
                              subtitle: Text('${_response!.cityName}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onTap: (() async {
                                SharedPreferencesService prefs =
                                    SharedPreferencesService();
                                await prefs.saveData(_response!.cityName, 0);
                                databaseWeather db = databaseWeather();
                                await db.createWeather(Weathermodel(
                                    cityName: _response!.cityName,
                                    isPined: false));
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage()));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ],
        ));
  }

  void getCityname() async {
    final response = await client.getCurrentWeather(cityController.text);
    setState(() {
      _response = response;
    });
  }
}
