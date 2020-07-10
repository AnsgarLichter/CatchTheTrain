import 'dart:convert';

import 'package:myapp/middleware/services/repositories.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';

import 'package:http/http.dart' as http;

class DeparturesClient extends DeparturesRepository {
  @override
  Future<List<Departure>> loadDepartures(Stop stop) async {
    String requestUrl = //TODO: service constants => byName / byStop / ...
        'https://live.kvv.de/webapp/departures/bystop/:stop_id?maxInfos=10&key=377d840e54b59adbe53608ba1aad70e8'; //TODO: API_KEY as constant
    requestUrl = requestUrl.replaceAll(':stop_id', stop.id);

    final http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return _mapResponse(response);
    } else {
      throw Exception('Failed to load departures');
    }
  }

  Future<List<Departure>> loadDeparturesByLine(Stop stop, String line) async {
    String requestUrl =
        'https://live.kvv.de/webapp/departures/byroute/:line_id/:stop_id?maxInfos=10&key=377d840e54b59adbe53608ba1aad70e8';
    requestUrl = requestUrl.replaceAll(':stop_id', stop.id);
    requestUrl = requestUrl.replaceAll(':line_id', line);

    final http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return _mapResponse(response);
    } else if (response.statusCode == 400) {
      throw Exception('Die Linie $line fährt an der Haltestelle ${stop.name} nicht!');
    } else {
      throw Exception('Failed to load departures');
    }
  }

  Future<List<Departure>> _mapResponse(http.Response response) async {
    final responseJson = json.decode(response.body);
    List departures = responseJson['departures'];
    return departures
        .map((departure) => new Departure.fromJson(departure))
        .toList();
  }
}
