import 'package:myapp/middleware/services/departures_client.dart';
import 'package:myapp/middleware/services/stops_client.dart';
import 'package:myapp/middleware/store_departure_middleware.dart';
import 'package:myapp/middleware/store_stops_middleware.dart';
import 'package:myapp/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAllMiddleware() {
  List<Middleware<AppState>> middleware = [];
  middleware.addAll(createStoreStopsMiddleware(new StopsClient()));
  middleware.addAll(createStoreDeparturesMiddleware(new DeparturesClient()));

  return middleware;
}