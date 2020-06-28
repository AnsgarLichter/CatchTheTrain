import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/departure_monitor/stop_item.dart';

class StopsList extends StatelessWidget {
  final List<Stop> stops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;

  StopsList(
      {@required this.stops, @required this.onOppose, @required this.onFavour});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildStopsList(),
    );
  }

  Widget _buildStopsList() {
    return ListView.builder(
        itemCount: stops.length,
        itemBuilder: (context, index) {
          final stop = stops[index];
          return Column(
            children: <Widget>[
              StopItem(stop: stop, onOppose: onOppose, onFavour: onFavour),
              Divider(height: 1.0),
            ],
          );
        });
  }
}
