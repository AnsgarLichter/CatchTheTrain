import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';

class DepartureItem extends StatelessWidget {
  final Departure departure;

  DepartureItem(this.departure);

  //TODO: Check if realtime true otherwise show *
  @override
  Widget build(BuildContext context) {
    String time = departure.time;
    if(!departure.realtime) time += "*";

    return ListTile(
      title: Text(departure.destination),
      leading: Icon(Icons.directions_transit),
      trailing: Text(time)
    );
  }
}
