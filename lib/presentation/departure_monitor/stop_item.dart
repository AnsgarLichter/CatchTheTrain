import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/stop.dart';

class StopItem extends StatelessWidget {
  final Stop stop;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;

  StopItem(
      {@required this.stop, @required this.onOppose, @required this.onFavour});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stop.name),
      leading: Icon(Icons.directions_transit),
      trailing: Icon(stop.isFavoured ? Icons.favorite : Icons.favorite_border,
          color: stop.isFavoured ? Colors.red : null),
      onTap: _onStopTapped,
    );
  }

  void _onStopTapped() {
    stop.isFavoured ? onOppose(stop) : onFavour(stop);
  }
}
