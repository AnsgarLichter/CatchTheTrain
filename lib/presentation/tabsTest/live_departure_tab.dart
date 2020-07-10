import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/loading_indicator.dart';
import 'package:myapp/presentation/tabsTest/departures_list.dart';

class LiveDepartureTab extends StatefulWidget {
  final Stop stop;
  final Map<Stop, List<Departure>> departures;
  final String errorMessage;
  final Function(Stop, String) onLoadDepartures;

  LiveDepartureTab(
      {@required this.stop,
      this.departures,
      @required this.onLoadDepartures,
      @required this.errorMessage})
      : super(key: Key(stop.id));

  @override
  LiveDepartureTabState createState() => LiveDepartureTabState();
}

class LiveDepartureTabState extends State<LiveDepartureTab> {
  String line = '';

  @override
  void initState() {
    widget.onLoadDepartures(widget.stop, line);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        _buildStopSign(),
        _buildFilterLineForm(),
        widget.errorMessage.isNotEmpty
            ? Text(widget.errorMessage)
            : widget.departures.length == 0
                ? LoadingIndicator()
                : DeparturesList(widget.departures[widget.stop]),
      ],
    ));
  }

  Widget _buildStopSign() {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
        onVerticalDragEnd: _onSwipeUp,
        child: Container(
            margin: const EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 15.0, top: 10.0, bottom: 10.0),
                      child: Text(widget.stop.name, style: textTheme.headline6),
                    )),
                DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 5.0, color: Colors.green[600]),
                          bottom:
                              BorderSide(width: 5.0, color: Colors.green[600]),
                          right:
                              BorderSide(width: 5.0, color: Colors.green[600]),
                        ),
                        color: Colors.yellow),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 9.5, bottom: 9.5, right: 20.0),
                      child: Icon(Icons.train),
                    )),
              ],
            )));
  }

  Widget _buildFilterLineForm() {
    return Form(
        autovalidate: true,
        onChanged: () {
          Form.of(primaryFocus.context).save();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 30.0, right: 15.0, top: 10.0, bottom: 30.0),
              width: 100,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Filter', //TODO: localization
                  labelText: 'Linie', //TODO: localization
                ),
                maxLength: 3,
                validator: _onValidateForm,
                onSaved: _onSaveForm,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15.0),
              color: Theme.of(context).primaryColorLight,
              child: IconButton(
                icon: Icon(Icons.save),
                tooltip: 'Speichern des Filters',
                onPressed: _onSaveButtonPressed,
              ),
            )
          ],
        ));
  }

  String _onValidateForm(String value) {
    final regExp =
        new RegExp(r'^[S]?[\d]{1,2}$', caseSensitive: false, multiLine: false);
    if (!regExp.hasMatch(value))
      return 'z. B: 1, S1, S32';
    else
      return null;
  }

  void _onSaveForm(String value) {
    line = value;
    widget.onLoadDepartures(widget.stop, line);
  }

  void _onSaveButtonPressed() {
    return;
  }

  void _onSwipeUp(DragEndDetails details) {
    widget.onLoadDepartures(widget.stop, line);

    Flushbar(
      title: 'Aktualisieren ...',
      message: 'Die Abfahrten werden geladen ...',
      icon: Icon(
        Icons.update,
        size: 28,
        color: Theme.of(context).primaryColorDark,
      ),
      leftBarIndicatorColor: Theme.of(context).primaryColorDark,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
