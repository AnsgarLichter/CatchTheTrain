import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/stop.dart';
import 'package:redux/redux.dart';


final stopsReducer = combineReducers<List<Stop>>([
  TypedReducer<List<Stop>, StopsLoadedAction>(_setLoadedStops),
]);

List<Stop> _setLoadedStops(List<Stop> stops, StopsLoadedAction action) {
  return action.stops;
}

//TODO: Extract
final favouredStopsReducer = combineReducers<List<Stop>>([
  TypedReducer<List<Stop>, FavouredStopsLoadedAction>(_setLoadedFavouredStops),
]);

List<Stop> _setLoadedFavouredStops(List<Stop> stops, FavouredStopsLoadedAction action) {
  return action.favouredStops;
}

