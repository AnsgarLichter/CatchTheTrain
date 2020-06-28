import 'package:flutter/material.dart';
import 'package:myapp/containers/active_tab.dart';
import 'package:myapp/containers/tab_selector.dart';
import 'package:myapp/localization.dart';
import 'package:myapp/models/app_tab.dart';
import 'package:myapp/containers/depature_monitor.dart';
import 'package:myapp/presentation/route_planning/route_planning_widget.dart';
import 'package:myapp/presentation/settings_widget.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: Key('homeScreen'));

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(builder: (BuildContext context, AppTab activeTab) {
      return Scaffold(
        appBar: AppBar(
          title: Text(ReduxLocalizations.of(context).appTitle)
        ),
        body: activeTab == AppTab.departureMonitor ? DepartureMonitor() : activeTab == AppTab.routePlanning ? RoutePlanning() : Settings(),
        bottomNavigationBar: TabSelector(),
      );
    });
  }
}
