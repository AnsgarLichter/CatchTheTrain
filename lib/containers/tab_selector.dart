import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:myapp/actions/actions.dart';
import 'package:myapp/models/app_state.dart';
import 'package:myapp/models/app_tab.dart';
import 'package:redux/redux.dart';

class TabSelector extends StatelessWidget {
  TabSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(
          key: Key('tabs'),
          //TODO: create keys enum
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColorLight,
          fixedColor: Theme.of(context).primaryColorDark,
          currentIndex: AppTab.values.indexOf(vm.activeTab),
          onTap: vm.onTabSelected,
          items: AppTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(
                tab == AppTab.departureMonitor
                    ? Icons.departure_board
                    : tab == AppTab.routePlanning
                        ? Icons.train
                        : Icons.settings,
                key: Key(
                  tab == AppTab.departureMonitor
                      ? 'departureMonitor'
                      : tab == AppTab.routePlanning
                          ? 'routePlanning'
                          : 'settings',
                ),
              ),
              title: Text(tab == AppTab.departureMonitor
                  ? 'Departure Monitor'
                  : tab == AppTab.routePlanning
                      ? 'Route Planning'
                      : 'Settings'),
            );
          }).toList(),
        );
      },
    );
  }
}

class _ViewModel {
  final AppTab activeTab;
  final Function(int) onTabSelected;

  _ViewModel({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      activeTab: store.state.activeTab,
      onTabSelected: (index) {
        store.dispatch(UpdateTabAction((AppTab.values[index])));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          activeTab == other.activeTab;

  @override
  int get hashCode => ConnectionState.active.hashCode;
}
