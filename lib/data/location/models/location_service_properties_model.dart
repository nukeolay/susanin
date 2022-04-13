import 'package:susanin/domain/location/entities/location_service_properties.dart';

class LocationServicePropertiesModel extends LocationServicePropertiesEntity {
  const LocationServicePropertiesModel({
    required bool isPermissionGranted,
    required bool isEnabled,
  }) : super(
          isPermissionGranted: isPermissionGranted,
          isEnabled: isEnabled,
        );
}
