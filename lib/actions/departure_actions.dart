//Load Departures Actions
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';

class LoadDeparturesAction {
  final Stop stop;

  LoadDeparturesAction(this.stop);

  @override
  String toString() {
    return 'LoadDeparturesAction{stop: $stop}';
  }
}

class LoadDeparturesByLineAction {
  final Stop stop;
  final String line;

  LoadDeparturesByLineAction(this.stop, this.line);

  @override
  String toString() {
    return 'LoadDeparturesByLineAction{stop: $stop}, {line: $line}';
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

class DeparturesNotLoadedAction {
  final Object error;

  DeparturesNotLoadedAction(this.error);

  @override
  String toString() {
    return 'DeparturesNotLoadedAction{error: $error}';
  }
}

class DeparturesByLineNotLoadedAction {
  final Object error;

  DeparturesByLineNotLoadedAction(this.error);

  @override
  String toString() {
    return 'DeparturesByLineNotLoadedAction{error: $error}';
  }
}

class SaveDeparturesFilterAction{
  final Stop stop;

  SaveDeparturesFilterAction(this.stop);

  @override
  String toString() {
    return 'SaveDeparturesFilterAction{stop: $stop}';
  }
}

class DeleteDeparturesFilterAction{
  final Stop stop;

  DeleteDeparturesFilterAction(this.stop);

  @override
  String toString() {
    return 'SaveDeparturesFilterAction{stop: $stop}';
  }
}