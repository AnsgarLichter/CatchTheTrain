import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/tabsTest/departures_list.dart';

class LiveDepartureTab extends StatefulWidget {
  final Stop stop;
  final List<Departure> departures;
  final Function(Stop) onLoadDepartures;

  LiveDepartureTab(
      {@required this.stop, this.departures, @required this.onLoadDepartures})
      : super(key: Key(stop.id));

  @override
  LiveDepartureTabState createState() => LiveDepartureTabState();
}

class LiveDepartureTabState extends State<LiveDepartureTab> {
  @override
  void initState() {
    widget.onLoadDepartures(widget.stop);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Center(
        child: Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 30.0, bottom: 45.0, left: 15.0),
          child: Text(widget.stop.name, style: textTheme.headline6),
        ),
        widget.departures != null
            ? DeparturesList(widget.departures)
            : Text(''),
      ],
    ));
  }
}
