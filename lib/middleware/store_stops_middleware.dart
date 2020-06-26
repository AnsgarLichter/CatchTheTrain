import 'package:myapp/actions/actions.dart';
import 'package:myapp/middleware/database_helper.dart';
import 'package:myapp/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:myapp/models/stop.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//TODO: Extract StopsRepository & LiveClient
abstract class StopsRepository {
  Future<List<Stop>> loadStops(String name);
  Future<List<Stop>> loadFavouredStops();
  void delete(Stop stop);
  void insert(Stop stop);
}

class StopsClient implements StopsRepository {
  final helper = DatabaseHelper.instance;

  @override
  Future<List<Stop>> loadStops(String name) async {
    List<Stop> searchedStops = await _loadStopsFromLiveAPI(name);
    List<Stop> favouredStops = await _loadStopsFromDatabase();
    return _mapStopsToOneList(searchedStops, favouredStops);
  }

  @override
  Future<List<Stop>> loadFavouredStops() async{
    return await _loadStopsFromDatabase();
  }

  @override
  void delete(Stop stop) {
    helper.delete(stop);
  }

  void insert(Stop stop) {
    helper.insert(stop);
  }

  Future<List<Stop>> _loadStopsFromLiveAPI(String name) async {
    String requestUrl = //TODO: service constants => byName / byStop / ...
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

  List<Stop> _mapStopsToOneList(List<Stop> searched, List<Stop> favoured) {
    for(var stop in searched) {
      favoured.contains(stop) ? stop.isFavoured = true : stop.isFavoured = false;
    }

    return searched;
  }
}




List<Middleware<AppState>> createStoreStopsMiddleware(
    StopsRepository stopsRepository) {
  final loadStops = _createLoadStops(stopsRepository);
  final loadFavouredStops = _createLoadFavouredStops(stopsRepository);
  final deleteStop = _createDeleteStops(stopsRepository);
  final insertStop = _createInsertStops(stopsRepository);

  return [
    TypedMiddleware<AppState, LoadStopsAction>(loadStops),
    TypedMiddleware<AppState, LoadFavouredStopsAction>(loadFavouredStops),
    TypedMiddleware<AppState, OpposeStopAction>(deleteStop),
    TypedMiddleware<AppState, FavourStopAction>(insertStop),
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
    ).catchError((error) => store.dispatch(StopsNotLoadedAction(error)));

    next(action);
  };
}

Middleware<AppState> _createLoadFavouredStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadFavouredStops().then(
          (stops) {
        store.dispatch(
          FavouredStopsLoadedAction(stops.toList()),
        );
      },
    ).catchError((error) => store.dispatch(StopsNotLoadedAction(error)));

    next(action);
  };
}

Middleware<AppState> _createDeleteStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.delete(action.stop);
    action.stop.isFavoured = false;
    next(action);
  };
}

Middleware<AppState> _createInsertStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.insert(action.stop);
    action.stop.isFavoured = true;
    next(action);
  };
}
