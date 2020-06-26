import 'package:redux/redux.dart';
import 'package:myapp/actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StopsLoadedAction>(_setLoaded),
  TypedReducer<bool, StopsLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}