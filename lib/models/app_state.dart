import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState({
    this.isLoading = false,
    this.activeTab = AppTab.departureMonitor,
    this.activeFilter = VisibilityFilter.all
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    AppTab activeTab,
    VisibilityFilter activeFilter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      activeTab: activeTab ?? this.activeTab,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      activeTab.hashCode ^
      activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              isLoading == other.isLoading &&
              activeTab == other.activeTab &&
              activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}

