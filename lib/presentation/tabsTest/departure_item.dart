import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';

class DepartureItem extends StatelessWidget {
  final Departure departure;

  DepartureItem(this.departure);

  @override
  Widget build(BuildContext context) {
    String time = departure.time;
    if (!departure.realtime) time += "*";

    return ListTile(
        title: Text(departure.destination),
        leading: SizedBox(
            width: 35.0,
            height: 30.0,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Theme.of(context).primaryColor),
                child: Container(
                  margin: EdgeInsets.only(
                      top: 7.5, bottom: 7.5, left: 5.0, right: 5.0),
                  child: Center(
                    child: Text(departure.route,
                        style: TextStyle(
                            color: Colors
                                .white)), //Icon(Icons.directions_transit),
                  ),
                ))),
        trailing: Text(time == '0' ? 'sofort' : time));
  }
}
