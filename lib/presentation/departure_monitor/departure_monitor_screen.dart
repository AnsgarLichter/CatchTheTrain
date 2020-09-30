import 'dart:developer';

import 'package:catchthetrain/localization.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/containers/app_loading.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_search_stop/search_stop_form.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_live_departure/live_departure_tab.dart';
import 'dart:math' as math;

import 'package:flutter_icons/flutter_icons.dart';

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
  bool swipe = true;

  @override
  void initState() {
    super.initState();
    //TODO: refactor tabs & uiTabs
    //TODO: reset branches in git and switch to correct branch
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

  void onSwipe(details) {
    int swipeDirection = details.velocity.pixelsPerSecond.dx.toInt();
    int maxSwipeIndex = widget.favouredStops.length;
    int actIndex = tabController.index;
    int newIndex;

    if(swipeDirection > 0 && actIndex == 0 || swipeDirection < 0 && actIndex == tabController.length -1)
        return;
    if(swipe) {
      newIndex = actIndex + (swipeDirection > 0 ? -1 : maxSwipeIndex == actIndex ? 0 : 1);
    } else {
      newIndex = swipeDirection > 0 ? 0 : actIndex;
      swipe = newIndex == 0;
    }

    tabController.animateTo(newIndex);
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
        body: GestureDetector(
          onHorizontalDragEnd: onSwipe,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: uiTabs,
          ),
        ));
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
    swipe = stop.isFavoured;
    if (widget.favouredStops.contains(stop)) {
      tabController.animateTo(1 + widget.favouredStops.indexOf(stop));
    } else {
      tabController.animateTo(
          1 + widget.favouredStops.length + widget.stops.indexOf(stop));
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
    }
  }
}
