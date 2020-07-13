import 'package:flutter/material.dart';
import 'package:myapp/containers/app_loading.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/departure_monitor/favoured_stops_overview.dart';
import 'package:myapp/presentation/departure_monitor/search_stop_form.dart';
import 'package:myapp/presentation/departure_monitor/stops_list.dart';
import 'package:myapp/presentation/tabsTest/live_departure_tab.dart';

class DepartureMonitorScreen extends StatelessWidget {
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final Map<Stop, List<Departure>> departures;
  final String errorMessage;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(String) onSave;
  final Function(Stop, String) onLoadDepartures;
  final Function(Stop) onSaveFilter;
  final Function(Stop) onDeleteFilter;

  DepartureMonitorScreen({
    Key key,
    @required this.stops,
    @required this.favouredStops,
    @required this.departures,
    @required this.errorMessage,
    @required this.onOppose,
    @required this.onFavour,
    @required this.onSave,
    @required this.onLoadDepartures,
    @required this.onSaveFilter,
    @required this.onDeleteFilter,
  });

  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return _buildDepartureMonitorScreen();
    });
  }

  DefaultTabController _buildDepartureMonitorScreen() {
    var tabs = <Widget>[];

    tabs.add(_buildSearchStopScreen());
    if (favouredStops.length > 0)
      tabs.add(FavouredStopsOverview(
          this.favouredStops, this.onOppose, this.onFavour));
    tabs.addAll(_buildLiveDepartureScreen());

    return DefaultTabController(
      length: tabs.length,
      initialIndex: favouredStops.length > 0 ? 1 : 0,
      child: Scaffold(
          body: TabBarView(
        children: tabs,
      )),
    );
  }

  Widget _buildSearchStopScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SearchStopForm(onSave),
          stops.length > 0
              ? StopsList(stops: stops, onOppose: onOppose, onFavour: onFavour)
              : Container(width: 0, height: 0),
        ],
      ),
    );
  }

  List<Widget> _buildLiveDepartureScreen() {
    var tabs = <Widget>[];

    favouredStops.forEach((stop) {
      tabs.add(LiveDepartureTab(
          stop: stop,
          departures: departures,
          errorMessage: errorMessage,
          onLoadDepartures: onLoadDepartures,
          onSaveFilter: onSaveFilter,
          onDeleteFilter: onDeleteFilter));
    });

    return tabs;
  }
}
