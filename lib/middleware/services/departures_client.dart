import 'dart:convert';

import 'package:myapp/middleware/services/repositories.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';

import 'package:http/http.dart' as http;

class DeparturesClient extends DeparturesRepository {
  static const API_KEY = '377d840e54b59adbe53608ba1aad70e8';

  @override
  Future<List<Departure>> loadDepartures(Stop stop) async {
    String requestUrl = //TODO: service constants => byName / byStop / ...
        'https://live.kvv.de/webapp/departures/bystop/:stop_id?maxInfos=10&key=:api_key'; //TODO: API_KEY as constant
    requestUrl = requestUrl.replaceAll(':api_key', API_KEY);
    requestUrl = requestUrl.replaceAll(':stop_id', stop.id);

    final http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return _parseResponse(response);
    } else if (response.statusCode == 400){
      throw Exception('An dieser Haltestelle sind keine Echtzeitinformationen verfügbar!');
    } else {
      throw Exception('Failed to load departures');
    }
  }

  Future<List<Departure>> loadDeparturesByLine(Stop stop, String line) async {
    String requestUrl =
        'https://live.kvv.de/webapp/departures/byroute/:line_id/:stop_id?maxInfos=10&key=:api_key';
    requestUrl = requestUrl.replaceAll(':api_key', API_KEY);
    requestUrl = requestUrl.replaceAll(':stop_id', stop.id);
    requestUrl = requestUrl.replaceAll(':line_id', line);

    final http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      return _parseResponse(response);
    } else if (response.statusCode == 400) {
      throw Exception('Die Linie $line existiert nicht!');
    } else {
      throw Exception('Failed to load departures');
    }
  }

  Future<List<Departure>> _parseResponse(http.Response response) async {
    final responseJson = json.decode(response.body);
    List departures = responseJson['departures'];
    return departures
        .map((departure) => new Departure.fromJson(departure))
        .toList();
  }
}
