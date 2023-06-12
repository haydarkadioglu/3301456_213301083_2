import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



Future getWeather(String city) async{


  var url, result, response, body, document, status, temperature;
  url = "https://havadurumu15gunluk.xyz/havadurumu/565/$city-hava-durumu-15-gunluk.html";

  url = Uri.parse(url);
  result = await http.get(url);
  body = result.body;
  document = parser.parse(body);

  status = document.querySelector(".status");
  //status = status.map((e) => e.text);

  temperature = document.querySelector('.temperature.type-1');

  return [status.text, temperature.text];
}


class weatherDB {
  static final _databaseName = 'weather_database.db';
  static final _databaseVersion = 1;
  static final table = 'my_table';

  static final columnId = 'id';
  static final city = 'city';


  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, _databaseName);

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $table (
      $columnId INTEGER PRIMARY KEY,
      $city TEXT
    )
  ''');
  }

  Future<int> insertData(String _city) async {
    final db = await database;

    final data = {
      city: _city,
    };

    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> updateData(int id, String newCity) async {
    final db = await database;

    final data = {
      city: newCity,
    };

    return await db.update(
      table,
      data,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }



}

