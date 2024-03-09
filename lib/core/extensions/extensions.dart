import 'dart:math';

import 'package:flutter/material.dart';
import 'package:susanin/core/constants/pointer_constants.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/presentation/common/widgets/glass_bottom_sheet.dart';

extension IntExtension on int {
  String toDistanceString(BuildContext context) {
    if (this < PointerConstants.minDistance) {
      return context.s.less_than_5_m;
    }
    if (this < PointerConstants.distanceThreshold) {
      return context.s.distance_meters(truncate().toString());
    }
    return context.s.distance_kilometers((this / 1000).toStringAsFixed(1));
  }
}

extension LocationStatusExtension on LocationStatus {
  String? toErrorMessage(BuildContext context) {
    switch (this) {
      case LocationStatus.disabled:
        return context.s.error_geolocation_disabled;
      case LocationStatus.notPermitted:
        return context.s.error_geolocation_permission;
      case LocationStatus.unknownError:
        return context.s.error_unknown;
      default:
        return null;
    }
  }
}

extension DoubleExtension on double {
  double toRadians() => this * pi / 180;
}

extension ContextExtension on BuildContext {
  S get s => S.of(this);

  Future<void> showGlassBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 0,
      builder: (context) {
        return GlassBottomSheet(child: builder(context));
      },
    );
  }
}
