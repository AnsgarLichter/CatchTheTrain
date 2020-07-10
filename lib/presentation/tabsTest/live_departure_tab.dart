import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/tabsTest/departures_list.dart';

class LiveDepartureTab extends StatefulWidget {
  final Stop stop;
  final Map<Stop, List<Departure>> departures;
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
    return Center(
        child: Column(
        children: <Widget>[
        _buildStopSign(),
        widget.departures.length > 0
            ? DeparturesList(widget.departures[widget.stop])
            : Text(''),
      ],
    ));
  }

  Widget _buildStopSign() {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.only(top: 30.0, bottom: 45.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 5.0, color: Colors.green[600]),
                        bottom: BorderSide(
                            width: 5.0, color: Colors.green[600]),
                        left: BorderSide(
                            width: 5.0, color: Colors.green[600])),
                    color: Colors.yellow),
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Text(widget.stop.name, style: textTheme.headline6),
                )),
            DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 5.0, color: Colors.green[600]),
                      bottom: BorderSide(
                          width: 5.0, color: Colors.green[600]),
                      right: BorderSide(
                          width: 5.0, color: Colors.green[600]),
                    ),
                    color: Colors.yellow),
                child: Container(
                  margin: const EdgeInsets.only(top: 9.5, bottom: 9.5, right: 9.5),
                  child: Icon(Icons.train),
                )),
          ],
        ));
  }
}
