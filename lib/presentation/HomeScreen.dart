import 'package:flutter/material.dart';
import 'package:catchthetrain/containers/active_tab.dart';
import 'package:catchthetrain/containers/tab_selector.dart';
import 'package:catchthetrain/localization.dart';
import 'package:catchthetrain/models/app_tab.dart';
import 'package:catchthetrain/containers/depature_monitor.dart';
import 'package:catchthetrain/presentation/route_planning/route_planning_widget.dart';
import 'package:catchthetrain/presentation/settings_widget.dart';

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
    // return ActiveTab(builder: (BuildContext context, AppTab activeTab) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text(ReduxLocalizations.of(context).translate('title')),
    //       backgroundColor: Theme.of(context).primaryColorDark,
    //     ),
    //     body: activeTab == AppTab.departureMonitor ? DepartureMonitor() : activeTab == AppTab.routePlanning ? RoutePlanning() : Settings(),
    //     bottomNavigationBar: TabSelector(),
    //   );
    // });

    return ActiveTab(builder: (BuildContext context, AppTab activeTab) {
      return activeTab == AppTab.departureMonitor ? DepartureMonitor() : activeTab == AppTab.routePlanning ? RoutePlanning() : Settings();
    });
  }
}
