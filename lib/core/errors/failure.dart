import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocationServiceUnknownFailure extends Failure {}

class LocationServiceDisabledFailure extends Failure {}

class LocationServiceDeniedFailure extends Failure {}

class LocationServiceDeniedForeverFailure extends Failure {}

class CompassFailure extends Failure {}

class LoadLocationPointsFailure extends Failure {}
