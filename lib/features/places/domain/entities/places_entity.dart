import 'package:equatable/equatable.dart';

import 'package:susanin/features/places/domain/entities/place_entity.dart';

class PlacesEntity extends Equatable {
  const PlacesEntity({
    required this.places,
    required this.activePlace,
  });

  final List<PlaceEntity> places;
  final PlaceEntity? activePlace;

  PlacesEntity copyWith({
    List<PlaceEntity>? places,
    PlaceEntity? activePlace,
    bool? clearActivePlace,
  }) {
    return PlacesEntity(
      places: places ?? this.places,
      activePlace:
          clearActivePlace == null ? null : activePlace ?? this.activePlace,
    );
  }

  @override
  List<Object?> get props => [places, activePlace];
}
