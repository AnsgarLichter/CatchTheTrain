import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:catchthetrain/models/app_state.dart';
import 'package:catchthetrain/selectors/selectors.dart';
import 'package:redux/redux.dart';

class AppLoading extends StatelessWidget {
  final Function(BuildContext context, bool isLoading) builder;

  AppLoading({ Key key, @required this.builder}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => isLoadingSelector(store.state),
      builder: builder,
    );
  }
}