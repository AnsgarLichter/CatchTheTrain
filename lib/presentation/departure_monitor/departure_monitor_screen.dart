import 'package:flutter/material.dart';
import 'package:myapp/containers/app_loading.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/departure_monitor/search_stop_form.dart';
import 'package:myapp/presentation/departure_monitor/stops_list.dart';

class DepartureMonitorScreen extends StatelessWidget {
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(String) onSave;

  DepartureMonitorScreen({
    Key key,
    @required this.stops,
    @required this.favouredStops,
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

/*  Material _buildDepartureMonitorScreen() {
    return Material( //TODO: Insert tabView instead of Material
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SearchStopForm(onSave),
            stops.length > 0 ? StopsList(stops: stops, onOppose: onOppose, onFavour: onFavour) : Container(width: 0, height: 0),
            //TODO: Create tabs => one tab per saved stop in database
          ],
        ),
      ),
    );
  }*/

  DefaultTabController _buildDepartureMonitorScreen() {
    var tabs = <Widget>[];
    tabs.add(_buildSearchStopScreen());
    tabs.addAll(_buildLiveDepartureScreen());


    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          body: TabBarView(
            children: tabs,
          )
      ),
    );
  }

  //TODO: Extract methods below
  Widget _buildSearchStopScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SearchStopForm(onSave),
          stops.length > 0 ? StopsList(stops: stops, onOppose: onOppose, onFavour: onFavour) : Container(width: 0, height: 0),
        ],
      ),
    );
  }

  List<Widget> _buildLiveDepartureScreen() {
    var tabs = <Widget>[];

    favouredStops.forEach((stop) {
      tabs.add(Center(
        child: Text(stop.name)
      ));
    });

    return tabs;
  }
}
