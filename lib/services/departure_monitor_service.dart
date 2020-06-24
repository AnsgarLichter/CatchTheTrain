import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/stop.dart';

Future<List<Stop>> loadStops(String stopName) async {
  String requestUrl =
      'https://live.kvv.de/webapp/stops/byname/:name?key=377d840e54b59adbe53608ba1aad70e8';
  requestUrl = requestUrl.replaceAll(':name', stopName);
  return await _loadStops(requestUrl);
}

Future<List<Stop>> _loadStops(String requestUrl) async {
  final http.Response response = await http.get(requestUrl);
  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    List responseList = responseJson['stops'];
    return responseList.map((jsonStop) => new Stop.fromJson(jsonStop)).toList();
  } else {
    throw Exception('Failed to load stops');
  }
}
