import 'package:flutter/material.dart';
import 'package:myapp/services/departure_monitor_service.dart';
import 'package:myapp/database/database_helper.dart';

class DepartuersMonitor extends StatefulWidget {
  @override
  DeparturesMonitorState createState() => DeparturesMonitorState();
}

class DeparturesMonitorState extends State<DepartuersMonitor> {
  bool showStops = false;
  DatabaseHelper helper = DatabaseHelper.instance;
  Future<List<Stop>> _futureStops;
  List<Stop> _savedStops;

  @override
  void initState() {
    helper.queryAll().then((value) =>
        value != null ? _savedStops = value : _savedStops = new List<Stop>());
    super.initState();
  }

  //TODO: Insert tabView instead of Material
  //TODO: Create tabs => one tab per saved stop in database
  //TODO: Implement service for live departues
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
              autovalidate: true,
              onChanged: () {
                Form.of(primaryFocus.context).save();
              },
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.train),
                  hintText: 'Enter station name',
                  labelText: 'Station name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a station name!';
                  }

                  return null;
                },
                onSaved: (String value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      showStops = true;
                      _futureStops = loadStops(value);
                    });
                  } else {
                    setState(() {
                      showStops = false;
                    });
                  }
                },
              ),
            ),
            showStops == false
                ? Container(width: 0, height: 0)
                : Expanded(
                    child: FutureBuilder<List<Stop>>(
                        future: _futureStops, builder: _buildFuture),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                  title: Text(snapshot.data[index].name),
                  leading: Icon(Icons.directions_transit),
                  trailing: Icon(
                      _savedStops.contains(snapshot.data[index])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _savedStops.contains(snapshot.data[index])
                          ? Colors.red
                          : null),
                  onTap: () {
                    setState(() {
                      var stop = snapshot.data[index];
                      if (_savedStops.contains(stop)) {
                        helper.delete(stop);
                        _savedStops.remove(snapshot.data[index]);
                      } else {
                        helper.insert(stop);
                        _savedStops.add(snapshot.data[index]);
                      }
                    });
                  }),
              Divider(height: 1.0),
            ],
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }

    return SizedBox(width: 30, height: 30, child: CircularProgressIndicator());
  }
}
