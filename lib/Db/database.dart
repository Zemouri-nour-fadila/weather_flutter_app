import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class databaseWeather {
  // unique database
  static Database? _db;

  Future<Database> get getDatabase async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDatabase();
      return _db!;
    }
  }

  // create db file (init)
  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    var path = join(databasePath, 'database.db');

    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  // create tables
  void _createTables(Database db, int version) async {
    await db.execute(
        "CREATE TABLE weather(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, cityName TEXT, isPined INTEGER)");
  }

  // CRUD date (create, read, update, delete)
  Future<List<Weather>> getWeathers() async {
    final database = await getDatabase;
    if (database.isOpen) {
      database.rawQuery("SELECT cityName from weather");
    }
    return [];
  }

  Future<void> createWeather(String cityName, bool isPined) async {
    final database = await getDatabase;
    if (database.isOpen) {
      await database.insert(
        'weather',
        {'cityName': cityName, 'isPined': isPined ? 1 : 0},
      );
    }
  }

  Future<void> updateWeather(int id, String cityName, bool isPined) async {
    final database = await getDatabase;
    if (database.isOpen) {
      await database.update(
        'weather',
        {'id': id, 'cityName': cityName, 'isPined': isPined ? 1 : 0},
      );
    }
  }

  Future<List<Weather>> getWeather(int id) async {
    final database = await getDatabase;
    if (database.isOpen) {
      database.rawQuery("SELECT cityName from weather WHERE id=$id");
    }
    return [];
  }
}
