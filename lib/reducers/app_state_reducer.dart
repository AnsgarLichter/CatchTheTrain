import 'package:catchthetrain/models/app_state.dart';
import 'package:catchthetrain/reducers/departures_reducer.dart';
import 'package:catchthetrain/reducers/error_reducer.dart';
import 'package:catchthetrain/reducers/loading_reducer.dart';
import 'package:catchthetrain/reducers/search_term_reducer.dart';
import 'package:catchthetrain/reducers/stops_reducer.dart';
import 'package:catchthetrain/reducers/tabs_reducer.dart';
import 'package:catchthetrain/reducers/visibility_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    stops: stopsReducer(state.stops, action),
    departures: departuresReducer(state.departures, action),
    favouredStops: favouredStopsReducer(state.favouredStops, action),
    activeFilter: visibilityReducer(state.activeFilter, action),
    activeTab: tabsReducer(state.activeTab, action),
    searchTerm: searchTermReducer(state.searchTerm, action),
    errorMessage: errorReducer(state.errorMessage, action),
  );
}