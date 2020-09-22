import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/presentation/departure_monitor/tab_live_departure/departure_item.dart';

class DeparturesList extends StatelessWidget {
  final List<Departure> departures;

  DeparturesList(this.departures);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildStopsList(),
    );
  }

  Widget _buildStopsList() {
    return ListView.builder(
        itemCount: departures.length,
        itemBuilder: (context, index) {
          final departure = departures[index];
          return Column(
            children: <Widget>[
              DepartureItem(departure),
              Divider(height: 1.0),
            ],
          );
        });
  }
}
