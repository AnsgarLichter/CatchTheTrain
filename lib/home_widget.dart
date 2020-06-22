import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/departures_monitor_widget.dart';
import 'package:myapp/route_planning_widget.dart';
import 'package:myapp/settings_widget.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KVV Live'),
      ),
      body: TabBarView(
        children: <Widget>[
          DeparturesMonitorWidget(),
          RoutePlanningWidget(),
          SettingsWidget()
        ],
        controller: tabController,
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.live_tv),
              text: 'Abfahrtsmonitor',
            ),
            Tab(icon: Icon(Icons.train), text: 'Routenplanung'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
          controller: tabController,
        ),
      ),
    );
  }
}
