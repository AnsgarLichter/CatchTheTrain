import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/models/app_state.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/actions/actions.dart';
import 'package:redux/redux.dart';

class DepartureMonitor extends StatelessWidget {
  DepartureMonitor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return Scaffold(); //TODO: Create presentation for departure monitor (form, stopsList, etc.)
      },
    );
  }
}

class _ViewModel {
  final List<Stop> stops;
  final bool loading;
  final Function(Stop, bool) onTrailingTapped;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;

  _ViewModel({
    @required this.stops,
    @required this.loading,
    @required this.onTrailingTapped,
    @required this.onOppose,
    @required this.onFavour,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      stops: null,
      loading: store.state.isLoading,
      onTrailingTapped: (stop, complete) {
        store.dispatch(null);
      },
      onOppose: (stop) {
        store.dispatch(OpposeStopAction(stop));
      },
      onFavour: (stop) {
        store.dispatch(FavourStopAction(stop));
      },
    );
  }
}