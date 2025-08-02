import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../icons/domain/entities/icon_entity.dart';
import 'geo_point.dart';

class Track extends Equatable {
  const Track({
    required this.id,
    required this.nextPointId,
    required this.points,
    required this.name,
    required this.icon,
    required this.notes,
  });

  factory Track.fromCoordinates({
    required String name,
    required IconEntity icon,
    required double latitude,
    required double longitude,
    required String? notes,
  }) {
    return Track(
      id: Uuid().v4(),
      name: name,
      points: [
        GeoPoint.fromCoordinates(latitude: latitude, longitude: longitude),
      ],
      icon: icon,
      nextPointId: null,
      notes: notes,
    );
  }

  final String id;
  final String name;
  final List<GeoPoint> points;
  final IconEntity icon;
  final String? nextPointId;
  final String? notes;

  GeoPoint? get nextPoint =>
      points.firstWhereOrNull((point) => point.id == nextPointId);

  Track copyWithNewPoint(GeoPoint point) {
    return this.copyWith(points: [...points, point]);
  }

  Track copyWith({
    String? name,
    List<GeoPoint>? points,
    IconEntity? icon,
    ValueGetter<String?>? nextPointId,
    ValueGetter<String?>? notes,
  }) {
    return Track(
      id: id,
      name: name ?? this.name,
      points: points ?? this.points,
      icon: icon ?? this.icon,
      nextPointId: nextPointId != null ? nextPointId() : this.nextPointId,
      notes: notes != null ? notes() : this.notes,
    );
  }

  @override
  List<Object?> get props => [id, name, points, icon, nextPointId, notes];
}
