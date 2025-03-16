import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../../../features/location/domain/repositories/location_repository.dart';
import '../../../../../features/settings/domain/repositories/settings_repository.dart';
import '../../../../common/ios_compass_settings.dart';
import '../../../../common/settings_switch.dart';
import 'cubit/tutorial_settings_cubit.dart';
import '../../widgets/tutorial_text.dart';

class TutorialSettings extends StatelessWidget {
  const TutorialSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsRepository = context.read<SettingsRepository>();
    final locationRepository = context.read<LocationRepository>();
    final compassRepository = context.read<CompassRepository>();

    return BlocProvider(
      create:
          (context) => TutorialSettingsCubit(
            compassRepository: compassRepository,
            locationRepository: locationRepository,
            settingsRepository: settingsRepository,
          )..init(),
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
      children: [
        TutorialText(context.s.tutorial_settings_disabled, isError: true),
        const SizedBox(height: 30),
        Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
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
                context.s.tutorial_settings_permission,
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
                context.s.tutorial_settings_no_compass,
                isError: true,
              ),
            if (Platform.isIOS) const IosCompassSettings(),
          ],
        );
      },
    );
  }
}
