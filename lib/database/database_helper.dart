import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableStops = 'stops';
final String columnId = 'id';
final String columnName = 'name';
final String columnLat = 'lat';
final String columnLon = 'lon';

class Stop {
  String id;
  String name;
  double lat;
  double lon;

  Stop({this.id, this.name, this.lat, this.lon});

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Stop.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    lat = map[columnLat];
    lon = map[columnLon];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnLat: lat,
      columnLon: lon,
      columnId: id
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stop &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          lon == other.lon &&
          lat == other.lat;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ lon.hashCode ^ lat.hashCode;
}

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

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
                $columnLon REAL NOT NULL
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
        columns: [columnId, columnName, columnLon, columnLat],
        where: '$columnName = ?',
        whereArgs: [name]);
    if (maps.length > 0) {
      return Stop.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Stop>> queryAll() async {
    Database db = await database;
    List<Map> maps = await db.query(tableStops,
        columns: [columnId, columnName, columnLon, columnLat]);
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
}
