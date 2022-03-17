import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_flutter_app/models/weather_model.dart';
import 'package:weather_flutter_app/models/weathermodel.dart';

class databaseWeather {
  static Database? _db;

  Future<Database> get getDatabase async {
    final databasePath = await getDatabasesPath();
    var path = join(databasePath, 'databases.db');
    _db = await openDatabase(path, version: 1, onCreate: _createTables);
    return _db!;
  }

  void _createTables(Database db, int version) async {
    await db.execute(
        "CREATE TABLE weather(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, cityName TEXT, isPined INTEGER)");
  }

  Future<void> createWeather(Weathermodel weather) async {
    final database = await getDatabase;

    await database.insert('weather', weather.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteWeather(Weathermodel weather) async {
    final database = await getDatabase;

    await database.delete(
      'weather',
      where: '"cityName" == ?',
      whereArgs: [weather.id],
    );
  }

  Future<List<Weathermodel>> getWeathers() async {
    final database = await getDatabase;

    List<Map<String, dynamic>> items = await database.query(
      'weather',
    );
    return List.generate(
        items.length,
        (index) => Weathermodel(
            id: items[index]['id'],
            cityName: items[index]['cityName'],
            isPined: items[index]['isPined'] == 1 ? true : false));
  }
}
