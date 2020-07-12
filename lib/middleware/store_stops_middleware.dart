import 'package:myapp/actions/actions.dart';
import 'package:myapp/middleware/services/repositories.dart';
import 'package:myapp/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreStopsMiddleware(
    StopsRepository stopsRepository) {
  final loadStops = _createLoadStops(stopsRepository);
  final loadFavouredStops = _createLoadFavouredStops(stopsRepository);
  final deleteStop = _createDeleteStops(stopsRepository);
  final insertStop = _createInsertStops(stopsRepository);
  final updateStop = _createUpdateFilter(stopsRepository);

  return [
    TypedMiddleware<AppState, LoadStopsAction>(loadStops),
    TypedMiddleware<AppState, LoadFavouredStopsAction>(loadFavouredStops),
    TypedMiddleware<AppState, OpposeStopAction>(deleteStop),
    TypedMiddleware<AppState, FavourStopAction>(insertStop),
    TypedMiddleware<AppState, SaveDeparturesFilterAction>(updateStop),
    TypedMiddleware<AppState, DeleteDeparturesFilterAction>(updateStop),
  ];
}

Middleware<AppState> _createLoadStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadStops(action.name).then(
      (stops) {
        store.dispatch(
          StopsLoadedAction(stops.toList()),
        );
      },
    ).catchError((error) => store.dispatch(StopsNotLoadedAction(error)));

    next(action);
  };
}

Middleware<AppState> _createLoadFavouredStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadFavouredStops().then(
      (stops) {
        store.dispatch(
          FavouredStopsLoadedAction(stops.toList()),
        );
      },
    ).catchError((error) => store.dispatch(StopsNotLoadedAction(error)));

    next(action);
  };
}

Middleware<AppState> _createDeleteStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.delete(action.stop);
    action.stop.isFavoured = false;
    next(action);
  };
}

Middleware<AppState> _createInsertStops(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.insert(action.stop);
    action.stop.isFavoured = true;
    next(action);
  };
}

Middleware<AppState> _createUpdateFilter(StopsRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.update(action.stop).then(
        (id) {
          //TODO: check if working --> I think not
          store.dispatch(LoadFavouredStopsAction());
        }
    );
    next(action);
  };
}
