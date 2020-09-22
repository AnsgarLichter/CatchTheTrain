import 'package:catchthetrain/middleware/services/departures_client.dart';
import 'package:catchthetrain/middleware/services/stops_client.dart';
import 'package:catchthetrain/middleware/store_departure_middleware.dart';
import 'package:catchthetrain/middleware/store_stops_middleware.dart';
import 'package:catchthetrain/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAllMiddleware() {
  List<Middleware<AppState>> middleware = [];
  middleware.addAll(createStoreStopsMiddleware(new StopsClient()));
  middleware.addAll(createStoreDeparturesMiddleware(new DeparturesClient()));

  return middleware;
}