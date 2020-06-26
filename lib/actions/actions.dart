import 'package:myapp/models/models.dart';
import 'package:myapp/models/stop.dart';



// Unused
class ClearCompletedAction {}



//Unused
class ToggleAllAction {}



// DatabaseActions
/*
* TODO: Create database middleware
* TODO: Listen to oppoe / favour event
* TODO: send action to trigger rebuild
*/
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



//TabActions
//TODO: Clear stops switching tabs
class UpdateTabAction {
  final AppTab newTab;

  UpdateTabAction(this.newTab);

  @override
  String toString() {
    return 'UpdateTabAction{newTab: $newTab}';
  }
}



// Load Stops Actions
class LoadStopsAction {
  final String name;

  LoadStopsAction(this.name);

  @override
  String toString() {
    return 'LoadStopsAction{name: $name}';
  }
}

class StopsLoadedAction {
  final List<Stop> stops;

  StopsLoadedAction(this.stops);

  @override
  String toString() {
    return 'LoadStopsAction{stops: $stops}';
  }
}

class StopsNotLoadedAction {}