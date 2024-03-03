import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:susanin/core/constants/pointer_constants.dart';
import 'package:susanin/features/location/domain/entities/position.dart';

extension IntExtension on int {
  String toDistanceString() {
    if (this < PointerConstants.minDistance) {
      return 'less_than_5_m'.tr();
    }
    if (this < PointerConstants.distanceThreshold) {
      return 'distance_meters'.tr(args: [truncate().toString()]);
    }
    return 'distance_kilometers'.tr(
      args: [(this / 1000).toStringAsFixed(1)],
    );
  }
}

extension LocationStatusExtension on LocationStatus {
  String? toErrorMessage() {
    switch (this) {
      case LocationStatus.disabled:
        return 'error_geolocation_disabled';
      case LocationStatus.notPermitted:
        return 'error_geolocation_permission';
      case LocationStatus.unknownError:
        return 'error_unknown';
      default:
        return null;
    }
  }
}

extension DoubleExtension on double {
  double toRadians() => this * pi / 180;
}
