import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = 'my_mark_database.db';
  static final _databaseVersion = 1;
  static final table = 'my_table';

  static final columnId = 'id';
  static final columnTitle = 'baslik';
  static final columnImageUrl = 'resimurl';
  static final columnTextUrl = 'metinurl';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final path = '${appDocumentsDirectory.path}/$_databaseName';


    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        $columnId INTEGER PRIMARY KEY,
        $columnTitle TEXT,
        $columnImageUrl TEXT,
        $columnTextUrl TEXT
      )
    ''');
  }

  Future<int> insertData(String title, String imageUrl, String textUrl) async {
    final db = await database;

    final data = {
      columnTitle: title,
      columnImageUrl: imageUrl,
      columnTextUrl: textUrl,
    };

    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> deleteData(int id) async {
    final db = await database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
