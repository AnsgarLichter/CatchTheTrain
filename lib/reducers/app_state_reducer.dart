import 'package:myapp/models/app_state.dart';
import 'package:myapp/reducers/loading_reducer.dart';
import 'package:myapp/reducers/tabs_reducer.dart';
import 'package:myapp/reducers/visibility_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    activeFilter: visibilityReducer(state.activeFilter, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}