import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:myapp/models/app_state.dart';
import 'package:myapp/models/stop.dart';

import 'package:myapp/actions/actions.dart';

import 'package:myapp/presentation/departure_monitor/departure_monitor_screen.dart';
import 'package:myapp/middleware/store_stops_middleware.dart';


class DepartureMonitor extends StatelessWidget {
  DepartureMonitor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return DepartureMonitorScreen(
          stops: vm.stops,
          onSave: vm.onSave,
          onOppose: vm.onOppose,
          onFavour: vm.onFavour,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Stop> stops;
  final bool loading;
  final Function(String) onSave;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(String name) loadStops;

  _ViewModel({
    @required this.stops,
    @required this.loading,
    @required this.onSave,
    @required this.onOppose,
    @required this.onFavour,
    @required this.loadStops,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      stops: store.state.stops,
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
      loadStops: (name) {
        // store.dispatch(LiveClient.getStops(name));
      }
    );
  }
}
