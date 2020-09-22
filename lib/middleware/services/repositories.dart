import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';

abstract class StopsRepository {
  Future<List<Stop>> loadStops(String name);

  Future<List<Stop>> loadFavouredStops();

  void delete(Stop stop);

  void insert(Stop stop);

  Future<int> update(Stop stop);
}


abstract class DeparturesRepository {
  Future<List<Departure>> loadDepartures(Stop stop);

  Future<List<Departure>> loadDeparturesByLine(Stop stop, String line);
}
