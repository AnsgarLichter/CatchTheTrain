import 'package:catchthetrain/localization.dart';
import 'package:catchthetrain/models/stop.dart';
import 'package:catchthetrain/presentation/departure_monitor/stops_list.dart';
import 'package:catchthetrain/presentation/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopLiveSearch extends StatefulWidget {
  final Function(String) onSave;
  final bool isLoading;
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(Stop) onSort;
  final Function(BuildContext, Stop) onStopTapped;

  const StopLiveSearch({
    Key key,
    @required this.onSave,
    @required this.isLoading,
    @required this.stops,
    @required this.favouredStops,
    @required this.onOppose,
    @required this.onFavour,
    @required this.onSort,
    @required this.onStopTapped,
  }) : super(key: key);

  @override
  _StopLiveSearchState createState() => new _StopLiveSearchState();
}

class _StopLiveSearchState extends State<StopLiveSearch> {
  String _errorEmptySearchTerm;
  bool _showStops = false;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _errorEmptySearchTerm =
        ReduxLocalizations.of(context).translate("input.station.name");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildLiveSearch(context),
          widget.isLoading
              ? LoadingIndicator
              : !_showStops || widget.stops.length == 0
              ? StopsList(
              widget.favouredStops, widget.onOppose, widget.onFavour, widget.onSort, true,
              onStopTapped: widget.onStopTapped)
              : StopsList(widget.stops, widget.onOppose, widget.onFavour, widget.onSort, false,
              onStopTapped: widget.onStopTapped),
        ],
      ),
    );
  }

  Widget _buildLiveSearch(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        Form.of(primaryFocus.context).validate();
      },
      child: Container(
        margin:
        EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0, bottom: 30.0),
        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.train),
              hintText: ReduxLocalizations.of(context)
                  .translate("input.station.name"),
              labelText:
              ReduxLocalizations.of(context).translate("station.name")),
          validator: _validateForm,
          onSaved: widget.onSave,
        ),
      ),
    );
  }

  String _validateForm(String value) {
    if (value.isEmpty) {
      this.setState(() {
        _showStops = false;
      });
      return _errorEmptySearchTerm;
    } else {
      this.setState(() {
        _showStops = true;
      });
      _formKey.currentState.save();
      return null;
    }
  }
}
