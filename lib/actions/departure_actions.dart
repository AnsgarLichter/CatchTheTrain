//Load Departures Actions
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';

class LoadDeparturesAction {
  final Stop stop;

  LoadDeparturesAction(this.stop);

  @override
  String toString() {
    return 'LoadStopsAction{stop: $stop}';
  }
}

class DeparturesLoadedAction {
  final Map<Stop, List<Departure>> departures;

  DeparturesLoadedAction(this.departures);

  @override
  String toString() {
    return 'DeparturesLoadedAction{departures: $departures}';
  }
}