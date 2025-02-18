import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IconEntity extends Equatable {
  const IconEntity({
    required this.iconData,
    required this.color,
  });
  final IconData iconData;
  final Color color;

  IconEntity copyWith({
    IconData? iconData,
    Color? color,
  }) {
    return IconEntity(
      iconData: iconData ?? this.iconData,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [iconData.codePoint, color.value];
}
