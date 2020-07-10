import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:redux/redux.dart';


final departuresReducer = combineReducers<Map<Stop, List<Departure>>>([
  TypedReducer<Map<Stop, List<Departure>>, DeparturesLoadedAction>(_setLoadedDepartures),
]);

Map<Stop, List<Departure>> _setLoadedDepartures(Map<Stop, List<Departure>> departures, DeparturesLoadedAction action) {
  var updatedDepartures = new Map<Stop, List<Departure>>();
  updatedDepartures.addAll(departures);
  updatedDepartures.addAll(action.departures);

  return updatedDepartures;
}
