import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_live_departure/departure_item.dart';

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
        physics: NeverScrollableScrollPhysics(),
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
