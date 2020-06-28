import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/departure.dart';
import 'package:redux/redux.dart';


final departuresReducer = combineReducers<List<Departure>>([
  TypedReducer<List<Departure>, DeparturesLoadedAction>(_setLoadedDepartures),
]);

List<Departure> _setLoadedDepartures(List<Departure> departures, DeparturesLoadedAction action) {
  return action.departures;
}
