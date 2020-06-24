import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/models/stop.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Stop> stops;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState({
    this.isLoading = false,
    this.stops = const [],
    this.activeTab = AppTab.departureMonitor,
    this.activeFilter = VisibilityFilter.all
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Stop> stops,
    AppTab activeTab,
    VisibilityFilter activeFilter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      stops: stops ?? this.stops,
      activeTab: activeTab ?? this.activeTab,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      stops.hashCode ^
      isLoading.hashCode ^
      activeTab.hashCode ^
      activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              stops == other.stops &&
              isLoading == other.isLoading &&
              activeTab == other.activeTab &&
              activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, stops: $stops, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}

