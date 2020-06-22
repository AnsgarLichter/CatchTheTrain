import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/view_widgets/route_planning/route_planning_widget.dart';
import 'package:myapp/view_widgets/departure_monitor/departures_monitor_widget.dart';
import 'package:myapp/view_widgets/settings_widget.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    DepartuersMonitor(),
    RoutePlanningWidget(),
    SettingsWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch The Train'),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _selectedIndex,
        items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.departure_board),
           title: Text('Departure Monitor'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.train),
           title: Text('Route Planning'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           title: Text('Settings')
         )
       ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
