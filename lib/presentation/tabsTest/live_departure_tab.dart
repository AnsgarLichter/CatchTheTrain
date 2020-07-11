import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/stop.dart';
import 'package:myapp/presentation/loading_indicator.dart';
import 'package:myapp/presentation/tabsTest/departures_list.dart';

class LiveDepartureTab extends StatefulWidget {
  final Stop stop;
  final Map<Stop, List<Departure>> departures;
  final String errorMessage;
  final Function(Stop, String) onLoadDepartures;
  final _formKey = GlobalKey<FormState>();

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
    return GestureDetector(
      onVerticalDragEnd: _onSwipeUp,
      child: Center(
        child: Column(
          children: <Widget>[
            _buildStopSign(),
            //_buildFilterLineForm(),
            widget.errorMessage.isNotEmpty
                ? Text(widget.errorMessage)
                : widget.departures.length == 0
                    ? LoadingIndicator()
                    : DeparturesList(widget.departures[widget.stop]),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(top: 30.0, bottom: 15.0, right: 15.0),
                child: FloatingActionButton(
                    backgroundColor: line.isNotEmpty
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight,
                    onPressed: () => _onFilterButtonPressed(context),
                    child: Icon(FontAwesome.filter)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStopSign() {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 5.0, color: Colors.green[600]),
                        bottom:
                            BorderSide(width: 5.0, color: Colors.green[600]),
                        left: BorderSide(width: 5.0, color: Colors.green[600])),
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
                      bottom: BorderSide(width: 5.0, color: Colors.green[600]),
                      right: BorderSide(width: 5.0, color: Colors.green[600]),
                    ),
                    color: Colors.yellow),
                child: Container(
                  margin:
                      const EdgeInsets.only(top: 9.5, bottom: 9.5, right: 20.0),
                  child: Icon(Icons.train),
                )),
          ],
        ));
  }

  String _onValidateForm(String value) {
    final regExp =
        new RegExp(r'^[S]?[\d]{1,2}$', caseSensitive: false, multiLine: false);
    if (line.isNotEmpty && value.isEmpty) {
      line = value;
      widget.onLoadDepartures(widget.stop, line);
      return null;
    } else if (!regExp.hasMatch(value))
      return 'z. B: 1, S1, S32';
    else
      return null;
  }

  void _onSaveForm(String value) {
    line = value;
    widget.onLoadDepartures(widget.stop, line);
  }

  void _onBottomSheetFilterButtonPressed() {
    final formState = widget._formKey.currentState;

    if (formState.validate()) {
      formState.save();
      Navigator.pop(context);
    }
  }

  void _onFilterButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            margin: EdgeInsets.only(
                top: 30.0, bottom: 30.0, left: 15.0, right: 15.0),
            height: 170,
            child: Form(
              key: widget._formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(FontAwesome.filter),
                      hintText: 'Filtern der Linien', //TODO: localization
                      labelText: 'Linie', //TODO: localization
                    ),
                    maxLength: 3,
                    validator: _onValidateForm,
                    onSaved: _onSaveForm,
                    initialValue: line,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FloatingActionButton.extended(
                          label: Text('Filter'), //TODO: Internationalization
                          icon: Icon(FontAwesome.filter),
                          backgroundColor: line.isNotEmpty
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          onPressed: _onBottomSheetFilterButtonPressed,
                        ),
                        FloatingActionButton.extended(
                          label: Text('Speichern'), //TODO: Internationalization
                          icon: Icon(Icons.save),
                          backgroundColor: Theme.of(context).primaryColorLight,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
