import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/stop_item.dart';

class StopsList extends StatelessWidget {
  final List<Stop> stops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(Stop) onSort;
  final Function(BuildContext, Stop) onStopTapped;
  final bool reorder;

  StopsList(this.stops, this.onOppose, this.onFavour, this.onSort, this.reorder,
      {this.onStopTapped});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _buildStopsList(context),
    );
  }

  Widget _buildStopsList(BuildContext context) {
    return ReorderableListView(
      onReorder: _onReorder,
      children: [
        for (final stop in stops)
          StopItem(
            stop,
            onOppose,
            onFavour,
            onStopTapped: onStopTapped,
          ).get(context),
      ],
    );
  }

  void _onReorder(int oldIndex, newIndex) {
    if (reorder) {
      var stop = stops[oldIndex];
      stop.sortPosition = newIndex;
      this.onSort(stop);
    }
  }
}
