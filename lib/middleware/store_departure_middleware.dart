import 'package:myapp/actions/actions.dart';
import 'package:myapp/middleware/services/repositories.dart';
import 'package:myapp/models/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreDeparturesMiddleware(
    DeparturesRepository departuresRepository) {
  final loadStops = _createLoadDepartures(departuresRepository);

  return [
    TypedMiddleware<AppState, LoadDeparturesAction>(loadStops),
  ];
}

Middleware<AppState> _createLoadDepartures(DeparturesRepository repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.loadDepartures(action.stop).then(
      (departures) {
        store.dispatch(
          DeparturesLoadedAction({action.stop:departures.toList()}),
        );
      },
    ).catchError((error) => store.dispatch(StopsNotLoadedAction(error)));

    next(action);
  };
}