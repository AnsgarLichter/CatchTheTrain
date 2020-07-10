import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/presentation/loading_indicator.dart';
import 'package:myapp/presentation/tabsTest/departure_item.dart';

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
    if(departures != null && departures.length > 0) {
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
    } else {
      return LoadingIndicator();
    }
  }
}
