import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:myapp/models/stop.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class StopsRepository {
  Future<List<Stop>> loadStops(String name);
}

class LiveClient implements StopsRepository {
  @override
  Future<List<Stop>> loadStops(String name) async {
    String requestUrl =
        'https://live.kvv.de/webapp/stops/byname/:name?key=377d840e54b59adbe53608ba1aad70e8';
    requestUrl = requestUrl.replaceAll(':name', name);
    final http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      List stops = responseJson['stops'];
      List<Stop> r = stops.map((stop) => new Stop.fromJson(stop)).toList();
      return r;
    } else {
      throw Exception('Failed to load stops');
    }
  }
}

List<Middleware<AppState>> createStoreStopsMiddleware(
    StopsRepository stopsRepository) {
  final loadStops = _createLoadStops(stopsRepository);

  return [
    TypedMiddleware<AppState, LoadStopsAction>(loadStops),
  ];
}

Middleware<AppState> _createLoadStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadStops(action.name).then(
      (stops) {
        store.dispatch(
          StopsLoadedAction(stops.toList()),
        );
      },
    ).catchError((_) => store.dispatch(StopsNotLoadedAction()));

    next(action);
  };
}
