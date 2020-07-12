import 'package:redux/redux.dart';
import 'package:myapp/actions/actions.dart';

final errorReducer = combineReducers<String>([
  TypedReducer<String, DeparturesByLineNotLoadedAction>(_setDeparturesNotLoaded),
  TypedReducer<String, DeparturesLoadedAction>(_setDeparturesLoaded),
]);


String _setDeparturesNotLoaded(String errorMessage, DeparturesByLineNotLoadedAction action) {
  return action.error.toString();
}

String _setDeparturesLoaded(String errorMessage, DeparturesLoadedAction action) {
  return '';
}
