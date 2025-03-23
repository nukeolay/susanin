import '../../../../core/constants/icon_constants.dart';
import 'icon_model.dart';
import '../../domain/entities/place_entity.dart';

class PlaceModel {
  const PlaceModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.name,
    required this.creationTime,
    required this.iconModel,
  });

  factory PlaceModel.fromEntity(PlaceEntity entity) {
    return PlaceModel(
      id: entity.id,
      latitude: entity.latitude,
      longitude: entity.longitude,
      notes: entity.notes,
      name: entity.name,
      creationTime: entity.creationTime,
      iconModel: IconModel.fromEntity(entity.icon),
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String? ?? DateTime.now().toString(),
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      notes: json['notes'] as String?,
      name: json['pointName'] as String,
      creationTime: DateTime.fromMillisecondsSinceEpoch(
        json['creationTime'] as int,
      ),
      iconModel: json['iconModel'] == null
          ? null
          : IconModel.fromJson(json['iconModel']! as Map<String, dynamic>),
    );
  }

  final String id;
  final double latitude;
  final double longitude;
  final String? notes;
  final String name;
  final DateTime creationTime;
  final IconModel? iconModel;

  Map<String, dynamic> toJson() => {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'pointName': name,
        'notes': notes,
        'creationTime': creationTime.millisecondsSinceEpoch,
        'iconModel': iconModel?.toJson(),
      };

  PlaceEntity toEntity() => PlaceEntity(
        creationTime: creationTime,
        id: id,
        latitude: latitude,
        longitude: longitude,
        notes: notes ?? '',
        name: name,
        icon: iconModel?.toEntity() ?? IconConstants.standard,
      );
}
