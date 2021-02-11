abstract class MyCompassEvent {}

class MyCompassEventGetCompass extends MyCompassEvent {}

class MyCompassEventHeadingChanged extends MyCompassEvent {
  double heading;
  MyCompassEventHeadingChanged({this.heading});
}

class MyCompassEventError extends MyCompassEvent {}