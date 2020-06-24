import 'package:myapp/models/models.dart';
import 'package:myapp/models/stop.dart';

class ClearCompletedAction {}

class ToggleAllAction {}

class LoadTodosAction {}

class TodosNotLoadedAction {}

class TodosLoadedAction {

}

class OpposeStopAction {
  final Stop stop;

  OpposeStopAction(this.stop);

  @override
  String toString() {
    return 'OpposeStopAction{stop: $stop}';
  }

}

class FavourStopAction {
  final Stop stop;

  FavourStopAction(this.stop);

  @override
  String toString() {
    return 'FavourStopAction{stop: $stop}';
  }
}

//TODO: Remove
class UpdateFilterAction {
  final VisibilityFilter newFilter;

  UpdateFilterAction(this.newFilter);

  @override
  String toString() {
    return 'UpdateFilterAction{newFilter: $newFilter}';
  }
}

class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}