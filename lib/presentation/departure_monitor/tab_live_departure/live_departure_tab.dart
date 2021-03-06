import 'package:catchthetrain/localization.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:catchthetrain/models/departure.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/loading_indicator.dart';
import 'package:catchthetrain/presentation/departure_monitor/tab_live_departure/departures_list.dart';

class LiveDepartureTab extends StatefulWidget {
  final bool isLoading;
  final Stop stop;
  final Map<Stop, List<Departure>> departures;
  final String errorMessage;
  final Function(Stop, String) onLoadDepartures;
  final Function(Stop) onSaveFilter;
  final Function(Stop) onDeleteFilter;
  final _formKey = GlobalKey<FormState>();

  LiveDepartureTab({
    @required this.isLoading,
    @required this.stop,
    this.departures,
    @required this.onLoadDepartures,
    @required this.errorMessage,
    @required this.onSaveFilter,
    @required this.onDeleteFilter,
  }) : super(key: Key(stop.id));

  @override
  LiveDepartureTabState createState() => LiveDepartureTabState();
}

class LiveDepartureTabState extends State<LiveDepartureTab> {
  String line = '';
  bool valueModified = false;

  @override
  void initState() {
    line = widget.stop.filter;
    widget.onLoadDepartures(widget.stop, line);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final departuresStop = widget.departures[widget.stop] ?? [];
    return GestureDetector(
      onVerticalDragEnd: _onSwipeUp,
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              _buildStopSign(),
              widget.isLoading
                  ? LoadingIndicator()
                  : widget.errorMessage.isNotEmpty
                      ? _buildErrorMessage()
                      : departuresStop.length > 0
                          ? DeparturesList(departuresStop)
                          : _buildNoDepartures(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: line.isNotEmpty
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColorLight,
            onPressed: () => _onFilterButtonPressed(context),
            child: Icon(FontAwesome.filter)),
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

  Widget _buildErrorMessage() {
    String message = widget.errorMessage.replaceAll('Exception: ', '');
    return _buildMessage(Icons.warning, Colors.red, message);
  }

  Widget _buildNoDepartures() {
    return _buildMessage(
        Icons.not_interested,
        Theme.of(context).primaryColorDark,
        ReduxLocalizations.of(context).translate('departures.noData'));
  }

  Widget _buildMessage(IconData icon, Color color, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: 150,
        ),
        Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0),
          child: Text(message, style: Theme.of(context).textTheme.bodyText1),
        )
      ],
    );
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
    else {
      valueModified = value == line ? false : true;
      return null;
    }
  }

  void _onSaveForm(String value) {
    line = value;
    valueModified = false;
    widget.onLoadDepartures(widget.stop, line);
  }

  void _onBottomSheetFilterButtonPressed() {
    final formState = widget._formKey.currentState;

    if (!valueModified && line.isNotEmpty) {
      line = '';
      widget.onLoadDepartures(widget.stop, line);
    } else if (formState.validate()) {
      formState.save();
    }

    Navigator.pop(context);
  }

  void _onBottomSheetSaveButtonPressed() {
    final formState = widget._formKey.currentState;

    if (widget.stop.filter.isNotEmpty) {
      line = '';
      widget.stop.filter = '';
      widget.onDeleteFilter(widget.stop);
      widget.onLoadDepartures(widget.stop, line);
      Navigator.pop(context);
    } else if (formState.validate()) {
      formState.save();
      Navigator.pop(context);
      widget.stop.filter = line;
      widget.onSaveFilter(widget.stop);
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(FontAwesome.filter),
                      hintText: ReduxLocalizations.of(context).translate('departures.noData'),
                      labelText: ReduxLocalizations.of(context).translate('departures.noData'),
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
                          label: Text(line.isNotEmpty
                              ? valueModified
                                  ? ReduxLocalizations.of(context).translate('filter.apply')
                                  : ReduxLocalizations.of(context).translate('filter.delete')
                              : ReduxLocalizations.of(context).translate('filter.apply')),
                          icon: Icon(FontAwesome.filter),
                          backgroundColor: line.isNotEmpty
                              ? valueModified
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          onPressed: _onBottomSheetFilterButtonPressed,
                        ),
                        FloatingActionButton.extended(
                          label: Text(widget.stop.filter.isNotEmpty
                              ? ReduxLocalizations.of(context).translate('delete')
                              : ReduxLocalizations.of(context).translate('save')),
                          icon: Icon(widget.stop.filter.isNotEmpty
                              ? Icons.delete
                              : Icons.save),
                          backgroundColor: widget.stop.filter.isNotEmpty
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).primaryColorLight,
                          onPressed: _onBottomSheetSaveButtonPressed,
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
      title: ReduxLocalizations.of(context).translate('refresh.title'),
      message: ReduxLocalizations.of(context).translate('refresh.message'),
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
