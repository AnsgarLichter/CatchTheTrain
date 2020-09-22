import 'package:redux/redux.dart';
import 'package:catchthetrain/actions/actions.dart';
import 'package:catchthetrain/models/models.dart';

final visibilityReducer = combineReducers<VisibilityFilter>([
  TypedReducer<VisibilityFilter, UpdateFilterAction>(_activeFilterReducer),
]);

VisibilityFilter _activeFilterReducer(
    VisibilityFilter activeFilter, UpdateFilterAction action) {
  return action.newFilter;
}