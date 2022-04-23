import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';

class LocationPointsState extends Equatable {
  final bool isLoading;
  final List<LocationPointEntity> locations;

  const LocationPointsState({
    required this.isLoading,
    required this.locations,
  });

  @override
  List<Object> get props => [isLoading, locations];
}
