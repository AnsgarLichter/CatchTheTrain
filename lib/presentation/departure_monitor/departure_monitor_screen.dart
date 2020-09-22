import 'package:flutter/material.dart';
import 'package:catchthetrain/containers/app_loading.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_overview_favoured_stops/favoured_stops_overview.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_search_stop/search_stop_form.dart';
import 'package:catchthetrain/presentation/departure_monitor/stops_list.dart';
import 'package:catchthetrain/presentation/loading_indicator.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_live_departure/live_departure_tab.dart';

class DepartureMonitorScreen extends StatelessWidget {
  final bool isLoading;
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
    @required this.isLoading,
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
          isLoading ? LoadingIndicator :
          stops.length > 0
              ? StopsList(stops, onOppose, onFavour)
              : Container(width: 0, height: 0),
        ],
      ),
    );
  }

  List<Widget> _buildLiveDepartureScreen() {
    var tabs = <Widget>[];

    favouredStops.forEach((stop) {
      tabs.add(LiveDepartureTab(
          isLoading: isLoading,
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
