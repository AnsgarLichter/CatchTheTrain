import 'package:catchthetrain/actions/actions.dart';
import 'package:redux/redux.dart';

final searchTermReducer = combineReducers<String>([
  TypedReducer<String, StopsLoadedAction>(_setSearchTerm),
]);

String _setSearchTerm(String searchTerm, StopsLoadedAction action) {
  return action.searchTerm;
}