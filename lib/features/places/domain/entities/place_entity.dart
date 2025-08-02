import 'package:equatable/equatable.dart';

import '../../../../core/constants/icon_constants.dart';
import '../../../icons/domain/entities/icon_entity.dart';
import '../../../tracks/domain/entities/geo_point.dart';

class PlaceEntity extends Equatable {
  const PlaceEntity._({
    required this.point,
    required this.name,
    required this.notes,
    required this.icon,
  });

  factory PlaceEntity({
    required String id,
    required double latitude,
    required double longitude,
    required DateTime creationTime,
    required String name,
    required String notes,
    required IconEntity icon,
  }) {
    return PlaceEntity._(
      point: GeoPoint(
        id: id,
        latitude: latitude,
        longitude: longitude,
        creationTime: creationTime,
      ),
      name: name,
      notes: notes,
      icon: icon,
    );
  }

  factory PlaceEntity.fromPoint({
    required GeoPoint point,
    required String name,
    required String notes,
    required IconEntity icon,
  }) {
    return PlaceEntity._(point: point, name: name, notes: notes, icon: icon);
  }

  PlaceEntity.empty()
    : point = GeoPoint(
        id: '',
        latitude: 0,
        longitude: 0,
        creationTime: DateTime(0),
      ),
      name = '',
      notes = '',
      icon = IconConstants.standard;

  PlaceEntity copyWith({
    double? latitude,
    double? longitude,
    String? name,
    String? notes,
    IconEntity? icon,
  }) {
    return PlaceEntity(
      id: id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      creationTime: creationTime,
      notes: notes ?? this.notes,
      icon: icon ?? this.icon,
    );
  }

  final GeoPoint point;
  final String name;
  final String notes;
  final IconEntity icon;
  String get id => point.id;
  double get longitude => point.longitude;
  double get latitude => point.latitude;
  DateTime get creationTime => point.creationTime;

  @override
  List<Object?> get props => [point, name, notes, icon];
}
