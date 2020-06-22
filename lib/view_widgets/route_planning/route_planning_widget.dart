import 'package:flutter/material.dart';

class RoutePlanningWidget extends StatelessWidget {
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
                Icons.train,
                size: 160.0,
                color: Theme.of(context).accentColor,
              ),
              Text(
                "Route Planning",
                style: TextStyle(color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}