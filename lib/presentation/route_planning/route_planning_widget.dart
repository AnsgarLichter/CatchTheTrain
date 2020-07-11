import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RoutePlanning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingActionButton(
          onPressed: _onFilterButtonPressed, child: Icon(FontAwesome.filter)),
    );
  }

  void _onFilterButtonPressed() {
    return;
  }
}
