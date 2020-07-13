import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/stop.dart';
import 'package:redux/redux.dart';

final searchTermReducer = combineReducers<String>([
  TypedReducer<String, StopsLoadedAction>(_setSearchTerm),
]);

String _setSearchTerm(String searchTerm, StopsLoadedAction action) {
  return action.searchTerm;
}