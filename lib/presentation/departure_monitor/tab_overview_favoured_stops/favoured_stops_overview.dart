import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/stops_list.dart';

class FavouredStopsOverview extends StatelessWidget {
  final List<Stop> favouredStops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;

  FavouredStopsOverview(this.favouredStops, this.onOppose, this.onFavour);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0, bottom: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            favouredStops.length > 0 ? StopsList(favouredStops, onOppose, onFavour, onStopTapped: onStopTapped,) : Container(width: 0, height: 0,)
          ],
        ),
      )
    );
  }

  void onStopTapped(BuildContext context, Stop stop) {
     DefaultTabController.of(context).animateTo(favouredStops.indexOf(stop) + 2);
  }
}
