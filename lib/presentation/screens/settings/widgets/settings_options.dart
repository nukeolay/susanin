import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_button.dart';

class SettingsOption extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsOption({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: child,
          ),
        ],
      ),
    );
  }
}

class LocationOption extends StatelessWidget {
  final SettingsState state;
  const LocationOption({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Доступ к геолокации',
      child: SettingsButton(
          text: state.locationSettingsStatus ==
                  LocationSettingsStatus.noPermission
              ? 'Предоставить доступ'
              : state.locationSettingsStatus == LocationSettingsStatus.loading
                  ? 'Загрузка'
                  : 'Доступ предоставлен',
          status: state.locationSettingsStatus ==
                  LocationSettingsStatus.noPermission
              ? ButtonStatus.failed
              : state.locationSettingsStatus == LocationSettingsStatus.loading
                  ? ButtonStatus.loading
                  : ButtonStatus.success,
          action: state.locationSettingsStatus ==
                  LocationSettingsStatus.noPermission
              ? () => context.read<SettingsCubit>().getPermission()
              : null),
    );
  }
}

class CompassOption extends StatelessWidget {
  final SettingsState state;
  const CompassOption({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Наличие компаса в устройстве',
      child: SettingsButton(
          text: state.compassSettingsStatus == CompassSettingsStatus.failure
              ? 'Компас не обнаружен'
              : state.compassSettingsStatus == CompassSettingsStatus.loading
                  ? 'Загрузка'
                  : 'Компас обнаружен',
          status: state.compassSettingsStatus == CompassSettingsStatus.failure
              ? ButtonStatus.failed
              : state.compassSettingsStatus == CompassSettingsStatus.loading
                  ? ButtonStatus.loading
                  : ButtonStatus.success,
          action: null),
    );
  }
}

class ExtraOptions extends StatelessWidget {
  const ExtraOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Дополнительно',
      child: Column(
        children: [
          SettingsButton(
              text: 'Просмотр инструкции',
              status: ButtonStatus.success,
              action: () {}),
          SettingsButton(
              text: 'Поставить оценку приложению',
              status: ButtonStatus.success,
              action: () {}),
        ],
      ),
    );
  }
}

class ThemeOption extends StatelessWidget {
  const ThemeOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Оформление',
      child: SettingsButton(
          text: 'Тема (светлая / темная)',
          status: ButtonStatus.success,
          action: () {}),
    );
  }
}

class WakelockOption extends StatelessWidget {
  final SettingsState state;
  const WakelockOption({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsOption(
      title: 'Автоматическое выключение экрана',
      child: SettingsButton(
          text: state.wakelockSettingsStatus == WakelockSettingsStatus.disabled
              ? 'Выключено'
              : state.wakelockSettingsStatus == WakelockSettingsStatus.disabled
                  ? 'Включено'
                  : 'Загрузка',
          status: state.wakelockSettingsStatus == WakelockSettingsStatus.disabled
              ? ButtonStatus.failed
              : state.wakelockSettingsStatus == WakelockSettingsStatus.loading
                  ? ButtonStatus.loading
                  : ButtonStatus.success,
          action: () => context.read<SettingsCubit>().toggleWakelock()),
    );
  }
}
