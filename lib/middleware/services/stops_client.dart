import 'dart:convert';

import 'package:catchthetrain/middleware/database/database_helper.dart';
import 'package:catchthetrain/middleware/services/repositories.dart';
import 'package:catchthetrain/models/stop.dart';

import 'package:http/http.dart' as http;

class StopsClient implements StopsRepository {
  final helper = DatabaseHelper.instance;

  @override
  Future<List<Stop>> loadStops(String name) async {
    List<Stop> searchedStops = await _loadStopsFromLiveAPI(name);
    List<Stop> favouredStops = await _loadStopsFromDatabase();
    return _mapStops(searchedStops, favouredStops);
  }

  @override
  Future<List<Stop>> loadFavouredStops() async {
    return await _loadStopsFromDatabase();
  }

  @override
  void delete(Stop stop) {
    helper.delete(stop);
  }

  void insert(Stop stop) {
    helper.insert(stop);
  }

  Future<int> update(Stop stop) async{
    int id = await helper.update(stop);
    return id;
  }

  Future<int> updateSortPosition(Stop stop) async{
    int id = await helper.updateSortPosition(stop);
    return id;
  }

  Future<List<Stop>> _loadStopsFromLiveAPI(String name) async {
    String requestUrl =
        'https://live.kvv.de/webapp/stops/byname/:name?key=377d840e54b59adbe53608ba1aad70e8';
    requestUrl = requestUrl.replaceAll(':name', name);
    final http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      List stops = responseJson['stops'];
      return stops.map((stop) => new Stop.fromJson(stop)).toList();
    } else {
      throw Exception('Failed to load stops');
    }
  }

  Future<List<Stop>> _loadStopsFromDatabase() async {
    return await helper.queryAll();
  }

  List<Stop> _mapStops(List<Stop> searched, List<Stop> favoured) {
    if(favoured == null) return searched;

    for (var stop in searched) {
      favoured.contains(stop)
          ? stop.isFavoured = true
          : stop.isFavoured = false;
    }

    return searched;
  }
}
