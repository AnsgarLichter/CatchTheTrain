import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:myapp/models/departure.dart';
import 'package:myapp/models/models.dart';
import 'package:myapp/models/stop.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Stop> stops;
  final List<Stop> favouredStops;
  final List<Departure> departures;
  final AppTab activeTab;
  final VisibilityFilter activeFilter;

  AppState({
    this.isLoading = false,
    this.stops = const [],
    this.favouredStops = const [],
    this.departures = const[],
    this.activeTab = AppTab.departureMonitor,
    this.activeFilter = VisibilityFilter.all
  });

  factory AppState.loading() => AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Stop> stops,
    List<Stop> favouredStops,
    List<Departure> departures,
    AppTab activeTab,
    VisibilityFilter activeFilter,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      stops: stops ?? this.stops,
      favouredStops: favouredStops ?? this.favouredStops,
      departures: departures ?? this.departures,
      activeTab: activeTab ?? this.activeTab,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }

  @override
  int get hashCode =>
      stops.hashCode ^
      favouredStops.hashCode ^
      departures.hashCode ^
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
              departures == other.departures &&
              isLoading == other.isLoading &&
              activeTab == other.activeTab &&
              activeFilter == other.activeFilter;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, stops: $stops, favouredStops: $favouredStops, departures: $departures, activeTab: $activeTab, activeFilter: $activeFilter}';
  }
}

