import 'package:catchthetrain/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchStopForm extends StatelessWidget {
  final Function(String) onSave;

  String valueIsEmpty;

  SearchStopForm(this.onSave);

  @override
  Widget build(BuildContext context) {
    valueIsEmpty = ReduxLocalizations.of(context).translate("input.station.name");

    return Form(
        autovalidate: true,
        onChanged: () {
          Form.of(primaryFocus.context).save();
        },
        child: Container(
          margin:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 30.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.train),
              hintText: ReduxLocalizations.of(context).translate("input.station.name"),
              labelText: ReduxLocalizations.of(context).translate("station.name")
            ),
            validator: _validateForm,
            onSaved: onSave,
          ),
        ));
  }

  String _validateForm(String value) {
    return value.isEmpty
        ? valueIsEmpty
        : null;
  }
}
