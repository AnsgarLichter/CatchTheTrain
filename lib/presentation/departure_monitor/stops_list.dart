import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/stop_item.dart';

class StopsList extends StatelessWidget {
  final List<Stop> stops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(BuildContext, Stop) onStopTapped;

  StopsList(this.stops, this.onOppose, this.onFavour, {this.onStopTapped});

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
              StopItem(stop, onOppose, onFavour, onStopTapped: onStopTapped,),
              Divider(height: 1.0),
            ],
          );
        });
  }
}
