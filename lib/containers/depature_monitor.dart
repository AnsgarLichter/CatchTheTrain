import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/models/departure.dart';
import 'package:redux/redux.dart';

import 'package:myapp/models/app_state.dart';
import 'package:myapp/models/stop.dart';

import 'package:myapp/actions/actions.dart';

import 'package:myapp/presentation/departure_monitor/departure_monitor_screen.dart';


class DepartureMonitor extends StatelessWidget {
  DepartureMonitor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DepartureMonitorScreen(
          stops: vm.stops,
          favouredStops: vm.favouredStops,
          departures: vm.departures,
          onSave: vm.onSave,
          onOppose: vm.onOppose,
          onFavour: vm.onFavour,
          onLoadDepartures: vm.onLoadDepartures,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final List<Departure> departures;
  final bool loading;
  final Function(String) onSave;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(Stop) onLoadDepartures;

  _ViewModel({
    @required this.stops,
    @required this.favouredStops,
    @required this.departures,
    @required this.loading,
    @required this.onSave,
    @required this.onOppose,
    @required this.onFavour,
    @required this.onLoadDepartures,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      stops: store.state.stops,
      favouredStops: store.state.favouredStops,
      departures: store.state.departures,
      loading: store.state.isLoading,
      onSave: (name) {
        store.dispatch(LoadStopsAction(name));
      },
      onOppose: (stop) {
        store.dispatch(OpposeStopAction(stop));
      },
      onFavour: (stop) {
        store.dispatch(FavourStopAction(stop));
      },
      onLoadDepartures: (stop) {
        store.dispatch(LoadDeparturesAction(stop));
      },
    );
  }
}
