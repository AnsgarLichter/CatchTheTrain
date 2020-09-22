import 'package:catchthetrain/actions/actions.dart';
import 'package:catchthetrain/middleware/services/repositories.dart';
import 'package:catchthetrain/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreDeparturesMiddleware(
    DeparturesRepository departuresRepository) {
  final loadStops = _createLoadDepartures(departuresRepository);
  final loadStopsByLine = _createLoadDeparturesByLine(departuresRepository);

  return [
    TypedMiddleware<AppState, LoadDeparturesAction>(loadStops),
    TypedMiddleware<AppState, LoadDeparturesByLineAction>(loadStopsByLine),
  ];
}

Middleware<AppState> _createLoadDepartures(DeparturesRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadDepartures(action.stop).then(
          (departures) {
        store.dispatch(
          DeparturesLoadedAction({action.stop: departures.toList()}),
        );
      },
    ).catchError((error) => store.dispatch(DeparturesNotLoadedAction(error)));

    next(action);
  };
}

Middleware<AppState> _createLoadDeparturesByLine(
    DeparturesRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadDeparturesByLine(action.stop, action.line).then(
            (departures) {
          store.dispatch(
            DeparturesLoadedAction({action.stop: departures.toList()}),
          );
        }
    ).catchError((error) => store.dispatch(DeparturesByLineNotLoadedAction(error)));
  };
}