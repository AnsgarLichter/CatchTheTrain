import 'package:redux/redux.dart';
import 'package:myapp/actions/actions.dart';

final errorReducer = combineReducers<String>([
  TypedReducer<String, DeparturesByLineNotLoadedAction>(_setDeparturesByLineNotLoaded),
  TypedReducer<String, DeparturesNotLoadedAction>(_setDeparturesNotLoaded),
  TypedReducer<String, DeparturesLoadedAction>(_setDeparturesLoaded),
]);


String _setDeparturesByLineNotLoaded(String errorMessage, DeparturesByLineNotLoadedAction action) {
  return action.error.toString();
}

String _setDeparturesNotLoaded(String errorMessage, DeparturesNotLoadedAction action) {
  return action.error.toString();
}

String _setDeparturesLoaded(String errorMessage, DeparturesLoadedAction action) {
  return '';
}
