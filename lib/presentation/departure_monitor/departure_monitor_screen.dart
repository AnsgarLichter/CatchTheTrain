import 'package:catchthetrain/localization.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/containers/app_loading.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_search_stop/search_stop_form.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_live_departure/live_departure_tab.dart';
import 'dart:math' as math;

class DepartureMonitorTab extends StatefulWidget {
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

  const DepartureMonitorTab({
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
  }) : super(key: key);

  @override
  _DepartureMonitorTabState createState() => new _DepartureMonitorTabState();
}

class _DepartureMonitorTabState extends State<DepartureMonitorTab>
    with TickerProviderStateMixin {
  TabController tabController;
  List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    if (tabs == null) {
      tabs = <Widget>[];
      tabs.add(_buildSearchStopScreen());
      tabs.addAll(_buildLiveDepartureScreen());
    }
    tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _updateTabController() {
    int newIndex;
    if (tabController.index >= tabs.length) {
      newIndex = math.max(0, tabs.length - 2);
    } else {
      newIndex = tabController.index;
    }

    tabController.dispose();
    tabController = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: newIndex,
    );
  }

  void _navigateToLast() {
    tabController.animateTo(tabs.length - 1);
  }

/*  @override
  Widget build(BuildContext context) {
    return AppLoading(builder: (context, loading) {
      return _buildDepartureMonitorScreen(context);
    });
  }*/

  Widget build(BuildContext context) {
    // Widget _buildDepartureMonitorScreen(BuildContext context) {
    var uiTabs = <Widget>[];
    uiTabs.add(_buildSearchStopScreen());
    uiTabs.addAll(_buildLiveDepartureScreen());

    return Scaffold(
      appBar: AppBar(
        title: Text(ReduxLocalizations.of(context).translate('title')),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: TabBarView(
        controller: tabController,
        children: uiTabs,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToLast,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchStopScreen() {
    return StopLiveSearch(
      onSave: widget.onSave,
      isLoading: widget.isLoading,
      stops: widget.stops,
      favouredStops: widget.favouredStops,
      onFavour: widget.onFavour,
      onOppose: widget.onOppose,
      onStopTapped: onStopTapped,
    );
  }

  List<Widget> _buildLiveDepartureScreen() {
    var tabs = <Widget>[];

    widget.favouredStops.forEach((stop) {
      tabs.add(LiveDepartureTab(
          isLoading: widget.isLoading,
          stop: stop,
          departures: widget.departures,
          errorMessage: widget.errorMessage,
          onLoadDepartures: widget.onLoadDepartures,
          onSaveFilter: widget.onSaveFilter,
          onDeleteFilter: widget.onDeleteFilter));
    });

    widget.stops.forEach((stop) {
      if (!widget.favouredStops.contains(stop)) {
        tabs.add(LiveDepartureTab(
            isLoading: widget.isLoading,
            stop: stop,
            departures: widget.departures,
            errorMessage: widget.errorMessage,
            onLoadDepartures: widget.onLoadDepartures,
            onSaveFilter: widget.onSaveFilter,
            onDeleteFilter: widget.onDeleteFilter));
      }
    });

    return tabs;
  }

  void onStopTapped(BuildContext context, Stop stop) {
    if (widget.favouredStops.contains(Stop)) {
      tabController.animateTo(widget.favouredStops.indexOf(stop));
    } else {
      tabController.animateTo(
          widget.favouredStops.length + widget.stops.indexOf(stop));
    }
  }

  @override
  void didUpdateWidget(DepartureMonitorTab oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isLoading != oldWidget.isLoading ||
        widget.stops != oldWidget.stops ||
        widget.favouredStops != oldWidget.favouredStops ||
        widget.departures != oldWidget.departures) {
      setState(() {
        tabs.clear();
        tabs.add(_buildSearchStopScreen());
        tabs.addAll(_buildLiveDepartureScreen());
        _updateTabController();
      });
      setState(() {});
    }
  }
}
