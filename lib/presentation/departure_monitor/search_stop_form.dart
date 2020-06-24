import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchStopForm extends StatelessWidget {
  final Function(String) onSave;

  SearchStopForm(this.onSave);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      onChanged: () {
        Form.of(primaryFocus.context).save();
      },
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.train),
          hintText: 'Enter station name', //TODO: localization
          labelText: 'Station name', //TODO: localization
        ),
        validator: _validateForm,
        onSaved: onSave,
      ),
    );
  }

  String _validateForm(String value) {
    return value.isEmpty
        ? 'Please enter a station name'
        : null; //TODO: localization
  }
}
