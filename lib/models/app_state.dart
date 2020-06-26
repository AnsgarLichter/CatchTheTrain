import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/models/stop.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState({
    this.isLoading = false,
    this.stops = const [],
    this.favouredStops = const [],
    this.activeTab = AppTab.departureMonitor,
    this.activeFilter = VisibilityFilter.all
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Stop> stops,
    List<Stop> favouredStops,
    AppTab activeTab,
    VisibilityFilter activeFilter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      stops: stops ?? this.stops,
      favouredStops: favouredStops ?? this.favouredStops,
      activeTab: activeTab ?? this.activeTab,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      stops.hashCode ^
      favouredStops.hashCode ^
      isLoading.hashCode ^
      activeTab.hashCode ^
      activeFilter.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              stops == other.stops &&
              favouredStops == other.favouredStops &&
              isLoading == other.isLoading &&
              activeTab == other.activeTab &&
              activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, stops: $stops, favouredStops: $favouredStops, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}

