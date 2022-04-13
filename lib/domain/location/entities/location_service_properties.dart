import 'package:equatable/equatable.dart';

class LocationServicePropertiesEntity extends Equatable {
  final bool isPermissionGranted;
  final bool isEnabled;

  const LocationServicePropertiesEntity({
    required this.isPermissionGranted,
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [
        isPermissionGranted,
        isEnabled,
      ];
}
