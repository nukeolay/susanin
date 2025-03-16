import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/routes.dart';
import '../../../core/extensions/extensions.dart';
import '../../../features/review/domain/review_repository.dart';
import '../../../generated/l10n.dart';
import '../../../internal/cubit/app_settings_cubit.dart';
import '../../common/snackbar_error_handler.dart';
import '../../common/susanin_button.dart';
import '../../common/ios_compass_settings.dart';
import '../../common/settings_switch.dart';
import '../cubit/settings_cubit.dart';
import 'widgets/settings_switches.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.s.settings),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ThemeSwitch(
                  isDarkTheme: context.isDarkTheme(),
                  action:
                      (_) async => context
                          .read<AppSettingsCubit>()
                          .toggleTheme()
                          .onError(SnackBarErrorHandler(context).onError),
                ),
                WakelockSwitch(
                  switchValue: state.isScreenAlwaysOn,
                  action:
                      (_) async => context
                          .read<SettingsCubit>()
                          .toggleWakelock()
                          .onError(SnackBarErrorHandler(context).onError),
                ),
                LocationServiceSwitch(
                  locationStatus: state.locationServiceStatus,
                  action:
                      (_) async => context
                          .read<SettingsCubit>()
                          .getPermission()
                          .onError(SnackBarErrorHandler(context).onError),
                ),
                if (!Platform.isIOS) HasCompassSwitch(state: state),
                SusaninButton(
                  type: ButtonType.ghost,
                  label: context.s.button_instruction,
                  onPressed: () {
                    unawaited(HapticFeedback.heavyImpact());
                    GoRouter.of(context).go(Routes.tutorial);
                  },
                ),
                if (Platform.isIOS) const IosCompassSettings(),
                SusaninButton(
                  type: ButtonType.ghost,
                  label: S.of(context).review_button,
                  onPressed:
                      () async => context
                          .read<ReviewRepository>()
                          .showReviewPrompt()
                          .onError(SnackBarErrorHandler(context).onError),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
