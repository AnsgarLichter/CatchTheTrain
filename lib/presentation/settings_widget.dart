import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(children: [
          Center(
            child: Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.settings,
                  size: 160.0,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  "Settings",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.delete,
                  size: 160.0,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  "Settings",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          Center(
            child: Column(
              // center the children
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.satellite,
                  size: 160.0,
                  color: Theme.of(context).accentColor,
                ),
                Text(
                  "Settings",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
