import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/presentation/common/components/susanin_button.dart';
import 'package:susanin/presentation/common/widgets/ios_compass_settings.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';
import 'package:susanin/presentation/common/widgets/settings_switch.dart';
import 'package:susanin/presentation/settings/view/widgets/settings_switches.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

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
                  isDarkTheme: isDarkTheme,
                  action: (_) => context.read<AppSettingsCubit>().toggleTheme(),
                ),
                WakelockSwitch(
                  switchValue: state.isScreenAlwaysOn,
                  action: (_) => context.read<SettingsCubit>().toggleWakelock(),
                ),
                LocationServiceSwitch(
                  locationStatus: state.locationServiceStatus,
                  action: (_) => context.read<SettingsCubit>().getPermission(),
                ),
                if (!Platform.isIOS) HasCompassSwitch(state: state),
                SusaninButton(
                  type: ButtonType.ghost,
                  label: context.s.button_instruction,
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.tutorial,
                      (route) => false,
                    );
                  },
                ),
                if (Platform.isIOS) const IosCompassSettings(),
                // SusaninButton(
                //     type: ButtonType.ghost, 
                //     label: 'Поставить оценку приложению',
                //     onPressed: () {}), // ! TODO add link
              ],
            );
          },
        ),
      ),
    );
  }
}
