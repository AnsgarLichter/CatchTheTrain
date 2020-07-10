import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';

abstract class StopsRepository {
  Future<List<Stop>> loadStops(String name);

  Future<List<Stop>> loadFavouredStops();

  void delete(Stop stop);

  void insert(Stop stop);
}


abstract class DeparturesRepository {
  Future<List<Departure>> loadDepartures(Stop stop);

  Future<List<Departure>> loadDeparturesByLine(Stop stop, String line);
}
