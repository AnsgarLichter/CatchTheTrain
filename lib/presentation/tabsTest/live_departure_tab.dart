import 'package:flutter/cupertino.dart';
import 'package:myapp/models/stop.dart';

class LiveDepartureTab extends StatefulWidget {
  final void Function() onInit;
  final Stop stop;

  LiveDepartureTab({@required this.onInit, @required this.stop}) : super(key: Key('homeScreen'));

  @override
  LiveDepartureTabState createState() => LiveDepartureTabState();
}

//In the onInit method a LoadLiveDeparturesAction will be called for this stop.
//TODO: How to parse LoadedLiveDepartures
class LiveDepartureTabState extends State<LiveDepartureTab> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(widget.stop.name),
    );
  }
}