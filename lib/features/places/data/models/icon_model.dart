import 'package:flutter/material.dart';

import '../../../../core/constants/icon_constants.dart';
import '../../domain/entities/icon_entity.dart';

class IconModel {
  const IconModel({
    required this.codePoint,
    required this.fontFamily,
    required this.color,
  });

  factory IconModel.fromEntity(IconEntity entity) {
    return IconModel(
      codePoint: entity.iconData.codePoint,
      fontFamily: entity.iconData.fontFamily,
      color: entity.color.value,
    );
  }

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      codePoint: json['codePoint'] as int?,
      fontFamily: json['fontFamily'] as String?,
      color: json['color'] as int?,
    );
  }

  final int? codePoint;
  final String? fontFamily;
  final int? color;

  Map<String, dynamic> toJson() => {
        'codePoint': codePoint,
        'fontFamily': fontFamily,
        'color': color,
      };

  IconEntity toEntity() => IconEntity(
        iconData: codePoint != null
            ? IconData(codePoint!, fontFamily: fontFamily)
            : IconConstants.standard.iconData,
        color: color != null ? Color(color!) : IconConstants.standard.color,
      );
}
