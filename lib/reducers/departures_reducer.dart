import 'package:catchthetrain/actions/actions.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:redux/redux.dart';


final departuresReducer = combineReducers<Map<Stop, List<Departure>>>([
  TypedReducer<Map<Stop, List<Departure>>, DeparturesLoadedAction>(_setLoadedDepartures),
  TypedReducer<Map<Stop, List<Departure>>, DeparturesByLineNotLoadedAction>(_setDeparturesByLineNotLoaded),
]);

Map<Stop, List<Departure>> _setLoadedDepartures(Map<Stop, List<Departure>> departures, DeparturesLoadedAction action) {
  var updatedDepartures = new Map<Stop, List<Departure>>();
  updatedDepartures.addAll(departures);
  updatedDepartures.addAll(action.departures);

  return updatedDepartures;
}

Map<Stop, List<Departure>> _setDeparturesByLineNotLoaded(Map<Stop, List<Departure>> departures, DeparturesByLineNotLoadedAction action) {
  return departures;
}
