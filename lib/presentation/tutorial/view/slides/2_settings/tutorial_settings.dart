import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/settings/domain/use_cases/get_theme_mode.dart';
import 'package:susanin/features/settings/domain/use_cases/toggle_theme.dart';
import 'package:susanin/presentation/common/widgets/ios_compass_settings.dart';
import 'package:susanin/presentation/common/widgets/settings_switch.dart';
import 'package:susanin/presentation/tutorial/view/slides/2_settings/cubit/tutorial_settings_cubit.dart';
import 'package:susanin/presentation/tutorial/view/widgets/tutorial_text.dart';

class TutorialSettings extends StatelessWidget {
  const TutorialSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsRepository = context.read<SettingsRepository>();
    final locationRepository = context.read<LocationRepository>();
    final compassRepository = context.read<CompassRepository>();

    final getCompassStream = GetCompassStream(compassRepository);
    final getPositionStream = GetPositionStream(locationRepository);
    final getThemeMode = GetThemeMode(settingsRepository);
    final toggleTheme = ToggleTheme(settingsRepository);
    final requestPermission = RequestPermission(locationRepository);

    return BlocProvider(
      create: (context) => TutorialSettingsCubit(
        getCompassStream: getCompassStream,
        getPositionStream: getPositionStream,
        getThemeMode: getThemeMode,
        requestPermission: requestPermission,
        toggleTheme: toggleTheme,
      ),
      child: const _TutorialSettingsView(),
    );
  }
}

class _TutorialSettingsView extends StatelessWidget {
  const _TutorialSettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorialSettingsCubit, TutorialSettingsState>(
      builder: (context, state) {
        final isServiceDisabled = state.locationStatus.isDisabled;
        return isServiceDisabled
            ? const ServiceDisabledInfo()
            : const ServicePermissionInfo();
      },
    );
  }
}

class ServiceDisabledInfo extends StatelessWidget {
  const ServiceDisabledInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TutorialText(
          'tutorial_settings_disabled'.tr(),
          isError: true,
        ),
        const SizedBox(height: 30),
        Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.error,
          ),
        )
      ],
    );
  }
}

class ServicePermissionInfo extends StatelessWidget {
  const ServicePermissionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TutorialSettingsCubit>();
    return BlocBuilder<TutorialSettingsCubit, TutorialSettingsState>(
      builder: (context, state) {
        final isFailure = state.locationStatus.isFailure;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFailure)
              TutorialText(
                'tutorial_settings_permission'.tr(),
                isError: true,
              ),
            const SizedBox(height: 10),
            LocationServiceSwitch(
              locationStatus: state.locationStatus,
              action: (_) => cubit.getPermission(),
            ),
            ThemeSwitch(
              isDarkTheme: state.isDarkTheme,
              action: (_) => cubit.toggleTheme(),
            ),
            if (!Platform.isIOS && state.compassStatus.isFailure)
              TutorialText(
                'tutorial_settings_no_compass'.tr(),
                isError: true,
              ),
            if (Platform.isIOS) const IosCompassSettings(),
          ],
        );
      },
    );
  }
}
