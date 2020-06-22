import 'package:flutter/material.dart';

class DeparturesMonitorWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.live_tv,
                size: 160.0,
                color: Theme.of(context).accentColor,
              ),
              Text(
                "First Tab",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
