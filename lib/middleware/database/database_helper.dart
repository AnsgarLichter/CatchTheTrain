import 'dart:io';
import 'package:myapp/models/stop.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  final String tableStops = 'stops';
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 2;

  static final String columnId = 'id';
  static final String columnName = 'name';
  static final String columnLat = 'lat';
  static final String columnLon = 'lon';
  static final String columnFilter = 'filter';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableStops (
                $columnId TEXT PRIMARY KEY,
                $columnName TEXT NOT NULL,
                $columnLat REAL NOT NULL,
                $columnLon REAL NOT NULL,
                $columnFilter TEXT
              )''');
  }

  Future<int> insert(Stop stop) async {
    Database db = await database;
    int id = await db.insert(tableStops, stop.toMap());
    return id;
  }

  Future<Stop> queryStop(String name) async {
    Database db = await database;
    List<Map> maps = await db.query(tableStops,
        columns: [columnId, columnName, columnFilter, columnLon, columnLat],
        where: '$columnName = ?',
        whereArgs: [name]);
    if (maps.length > 0) {
      return Stop.fromMap(maps.first);
    }
    return null;
  }

  Future<Stop> getStop(String id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableStops,
        columns: [columnId, columnName, columnFilter, columnLon, columnLat],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Stop.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Stop>> queryAll() async {
    Database db = await database;
    List<Map> maps = await db.query(tableStops,
        columns: [columnId, columnName, columnFilter, columnLon, columnLat]);
    if (maps.length > 0) {
      return List.generate(maps.length, (i) {
        return Stop.fromMap(maps[i]);
      });
    }
    return null;
  }

  Future<int> delete(Stop stop) async {
    Database db = await database;
    int id = await db.delete(tableStops, where: 'id = ?', whereArgs: [stop.id]);
    return id;
  }

  Future<int> update(Stop stop) async {
    Database db = await database;
    int id = await db.update(tableStops, stop.toMap(), where: 'id = ?', whereArgs: [stop.id]);
    return id;
  }
}
