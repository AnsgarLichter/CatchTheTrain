// Load Stops Actions
import 'package:catchthetrain/models/stop.dart';

class LoadStopsAction {
  final String name;

  LoadStopsAction(this.name);

  @override
  String toString() {
    return 'LoadStopsAction{name: $name}';
  }
}

class StopsLoadedAction {
  final String searchTerm;
  final List<Stop> stops;

  StopsLoadedAction(this.searchTerm, this.stops);

  @override
  String toString() {
    return 'LoadStopsAction{searchTerm: $searchTerm, stops: $stops}';
  }
}


class LoadFavouredStopsAction {}
class FavouredStopsLoadedAction {
  final List<Stop> favouredStops;

  FavouredStopsLoadedAction(this.favouredStops);

  @override
  String toString() {
    return 'FavouredStopsLoadedAction{stops: $favouredStops}';
  }
}

class StopsNotLoadedAction {
  final Object error;

  StopsNotLoadedAction(this.error);

  @override
  String toString() {
    return 'StopsNotLoadedAction{error: $error}';
  }
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

class SortStopAction {
  final Stop stop;

  SortStopAction(this.stop);

  @override
  String toString() {
    return 'SortStopAction{stop: $stop';
  }
}