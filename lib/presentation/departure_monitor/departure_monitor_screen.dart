import 'package:flutter/material.dart';
import 'package:myapp/containers/app_loading.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/departure_monitor/search_stop_form.dart';
import 'package:myapp/presentation/departure_monitor/stops_list.dart';
import 'package:myapp/presentation/loading_indicator.dart';

class DepartureMonitorScreen extends StatelessWidget {
  final List<Stop> stops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(String) onSave;

  DepartureMonitorScreen({
    Key key,
    @required this.stops,
    @required this.onOppose,
    @required this.onFavour,
    @required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      // return loading ? LoadingIndicator(key: Key('loading')) : _buildDepartureMonitorScreen(); //TODO: global keys
      return _buildDepartureMonitorScreen();
    });
  }

  Material _buildDepartureMonitorScreen() {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchStopForm(onSave),
            stops.length > 0 ? StopsList(stops: stops, onOppose: onOppose, onFavour: onFavour) : Container(width: 0, height: 0),
          ],
        ),
      ),
    );
  }
}
  //TODO: Insert tabView instead of Material
  //TODO: Create tabs => one tab per saved stop in database
  //TODO: Implement service for live departues
