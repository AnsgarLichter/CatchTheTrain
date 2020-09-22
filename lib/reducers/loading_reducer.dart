import 'package:redux/redux.dart';
import 'package:catchthetrain/actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, StopsLoadedAction>(_setLoaded),
  TypedReducer<bool, LoadStopsAction>(_setLoading),
  TypedReducer<bool, StopsNotLoadedAction>(_setLoaded),
  TypedReducer<bool, FavouredStopsLoadedAction>(_setLoaded),
  TypedReducer<bool, LoadFavouredStopsAction>(_setLoading),
  TypedReducer<bool, DeparturesLoadedAction>(_setLoaded),
  TypedReducer<bool, LoadDeparturesAction>(_setLoading),
  TypedReducer<bool, DeparturesNotLoadedAction>(_setLoaded),
  TypedReducer<bool, LoadDeparturesByLineAction>(_setLoaded),
  TypedReducer<bool, DeparturesByLineNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setLoading(bool state, action) {
  return false;
}