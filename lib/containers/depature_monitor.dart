import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:redux/redux.dart';

import 'package:catchthetrain/models/app_state.dart';
import 'package:catchthetrain/models/stop.dart';

import 'package:catchthetrain/actions/actions.dart';

import 'package:catchthetrain/presentation/departure_monitor/departure_monitor_screen.dart';

class DepartureMonitor extends StatelessWidget {
  DepartureMonitor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DepartureMonitorTab(
          isLoading: vm.isLoading,
          stops: vm.stops,
          favouredStops: vm.favouredStops,
          departures: vm.departures,
          errorMessage: vm.errorMessage,
          onSave: vm.onSave,
          onOppose: vm.onOppose,
          onFavour: vm.onFavour,
          onSort: vm.onSort,
          onLoadDepartures: vm.onLoadDepartures,
          onSaveFilter: vm.onSaveFilter,
          onDeleteFilter: vm.onDeleteFilter,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final Map<Stop, List<Departure>> departures;
  final bool isLoading;
  final String searchTerm;
  final String errorMessage;
  final Function(String) onSave;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(Stop) onSort;
  final Function(Stop, String) onLoadDepartures;
  final Function(Stop) onSaveFilter;
  final Function(Stop) onDeleteFilter;

  _ViewModel({
    @required this.stops,
    @required this.favouredStops,
    @required this.departures,
    @required this.isLoading,
    @required this.searchTerm,
    @required this.errorMessage,
    @required this.onSave,
    @required this.onOppose,
    @required this.onFavour,
    @required this.onSort,
    @required this.onLoadDepartures,
    @required this.onSaveFilter,
    @required this.onDeleteFilter,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      stops: store.state.stops,
      favouredStops: store.state.favouredStops,
      departures: store.state.departures,
      isLoading: store.state.isLoading,
      searchTerm: store.state.searchTerm,
      errorMessage: store.state.errorMessage,
      onSave: (name) {
        store.dispatch(LoadStopsAction(name));
      },
      onOppose: (stop) {
        store.dispatch(OpposeStopAction(stop));
        store.dispatch(LoadFavouredStopsAction());
        store.dispatch(LoadStopsAction(store.state.searchTerm));
      },
      onFavour: (stop) {
        store.dispatch(FavourStopAction(stop));
        store.dispatch(LoadFavouredStopsAction());
        store.dispatch(LoadStopsAction(store.state.searchTerm));
      },
      onSort: (stop) {
        store.dispatch(SortStopAction(stop));
      },
      onLoadDepartures: (stop, line) {
        if (line.isNotEmpty)
          store.dispatch(LoadDeparturesByLineAction(stop, line));
        else
          store.dispatch(LoadDeparturesAction(stop));
      },
      onSaveFilter: (stop) {
        store.dispatch(SaveDeparturesFilterAction(stop));
      },
      onDeleteFilter: (stop) {
        store.dispatch(DeleteDeparturesFilterAction(stop));
      },
    );
  }
}
