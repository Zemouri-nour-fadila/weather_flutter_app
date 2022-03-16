import 'package:flutter/material.dart';
import 'package:weather_flutter_app/Db/database.dart';
import 'package:weather_flutter_app/models/weather_model.dart';
import 'package:weather_flutter_app/services/shared_preferences_service.dart';
import '../services/weather_api_client.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Weather? _response = null;

  @override
  void initState() {
    super.initState();
  }

  SharedPreferencesService prefs = SharedPreferencesService();
  late final cityName;
  late final isPined;

  final List<int> _items = List<int>.generate(50, (int index) => index);

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
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: <Widget>[
          for (int index = 0; index < _items.length; index += 1)
            if (_response != null)
              Card(
                key: Key('$index'),
                elevation: 10,
                color: const Color.fromARGB(255, 248, 248, 255),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                            "http://openweathermap.org/img/w/${_response!.icon}.png"),
                        trailing: Text(
                          '${_response!.degree}',
                          style: const TextStyle(fontSize: 30.0),
                        ),
                        title: Text('${_response!.cityName}',
                            style: const TextStyle(color: Colors.black)),
                        subtitle: Text('${_response!.cityName}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        onTap: (() async {}),
                      ),
                    ),
                  ],
                ),
              ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
    );
  }

  void getCityname() async {
    WeatherApiClient client = WeatherApiClient();
    Weather? data;
    String? name = await prefs.getCityName();
    final response = await client.getCurrentWeather(name!);
    setState(() {
      _response = response;
    });
  }
}
