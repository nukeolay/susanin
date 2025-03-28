import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/pointer_constants.dart';
import '../../generated/l10n.dart';
import '../../internal/cubit/app_settings_cubit.dart';
import '../../features/location/domain/entities/position.dart';
import '../../presentation/common/susanin_bottom_sheet.dart';

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

  Future<void> showSusaninBottomSheet({
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
        return SusaninBottomSheet(child: builder(context));
      },
    );
  }

  bool isDarkTheme() => select<AppSettingsCubit, bool>((cubit) {
        final state = cubit.state;
        if (state is AppSettingsLoadedState) {
          return state.isDarkTheme;
        }
        return false;
      });
}
