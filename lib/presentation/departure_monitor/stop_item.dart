import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:catchthetrain/models/stop.dart';

class StopItem extends StatelessWidget {
  final Stop stop;
  final Function(Stop) onOppose;
  final Function(Stop) onFavour;
  final Function(BuildContext, Stop) onStopTapped;

  StopItem(this.stop, this.onOppose, this.onFavour, {this.onStopTapped});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stop.name),
      leading: Icon(Icons.directions_transit, color: Theme
          .of(context)
          .primaryColor),
      trailing: IconButton(
          icon: Icon(stop.isFavoured ? Icons.favorite : Icons.favorite_border,
              color: stop.isFavoured ? Colors.red : null),
          color: Colors.white,
          onPressed: _onIconPressed,),
      onTap: () => _onStopTapped(context),
    );
  }

  void _onStopTapped(BuildContext context) {
    onStopTapped != null ? onStopTapped(context, stop) : _onIconPressed();
  }

  void _onIconPressed() {
    stop.isFavoured ? onOppose(stop) : onFavour(stop);
  }
}
