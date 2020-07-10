class Departure {
  String route;
  String destination;
  String time;
  String direction;
  /* traction shows the number of wagons used. Valid values are:
  *  0 --> 1 wagon
  *  2 --> 2 wagons */
  int traction;
  bool lowfloor;
  bool realtime;

  bool isFavoured;

  Departure({this.route, this.destination, this.time, this.direction, this.traction, this.lowfloor, this.realtime});

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      route: json['route'],
      destination: json['destination'],
      time: json['time'],
      direction: json['direction'],
      lowfloor: json['lowfloor'],
      realtime: json['realtime'],
      traction: json['traction'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Departure &&
              runtimeType == other.runtimeType &&
              route == other.route &&
              destination == other.destination &&
              time == other.time &&
              traction == other.traction &&
              direction == other.direction &&
              lowfloor == other.lowfloor &&
              realtime == other.realtime;

  @override
  int get hashCode => route.hashCode ^ destination.hashCode ^ time.hashCode ^ traction.hashCode ^ direction.hashCode ^ lowfloor.hashCode ^ realtime.hashCode;
}