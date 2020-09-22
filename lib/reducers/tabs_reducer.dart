import 'package:catchthetrain/actions/actions.dart';
import 'package:redux/redux.dart';
import 'package:catchthetrain/models/models.dart';

final tabsReducer = combineReducers<AppTab>([
  TypedReducer<AppTab, UpdateTabAction>(_activeTabReducer),
]);

AppTab _activeTabReducer(AppTab activeTab, UpdateTabAction action) {
  return action.newTab;
}