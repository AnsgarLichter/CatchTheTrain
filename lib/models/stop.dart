import 'file:///C:/Users/Ansgar/Documents/git/myapp/lib/middleware/database_helper.dart';

class Stop {
  String id;
  String name;
  double lat;
  double lon;
  bool isFavoured;

  Stop({this.id, this.name, this.lat, this.lon, this.isFavoured});

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      isFavoured: false,
    );
  }

  Stop.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.columnId];
    name = map[DatabaseHelper.columnName];
    lat = map[DatabaseHelper.columnLat];
    lon = map[DatabaseHelper.columnLon];
    isFavoured = true;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnLat: lat,
      DatabaseHelper.columnLon: lon,
      DatabaseHelper.columnId: id
    };

    if (id != null) {
      map[DatabaseHelper.columnId] = id;
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