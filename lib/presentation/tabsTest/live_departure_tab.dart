import 'package:flutter/cupertino.dart';
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
    return Center(
        child: Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(15.0),
          child: Text(widget.stop.name, style: TextStyle(fontSize: 20)),
        ),
        widget.departures != null
            ? DeparturesList(widget.departures)
            : Text(''),
      ],
    ));
  }
}
