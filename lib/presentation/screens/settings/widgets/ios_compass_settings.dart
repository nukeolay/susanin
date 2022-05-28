import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/presentation/screens/settings/widgets/settings_button.dart';

class IosCompassSettings extends StatelessWidget {
  const IosCompassSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Если указатель компаса не вращается при перемещении телефона, необходимо включить калибровку компаса:\nНастройки -> Конфиденциальность -> Службы геолокации -> Калибровка компаса.',
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        SettingsButton(
            text: '1 Перейти в настройки',
            action: AppSettings.openAccessibilitySettings),
        SettingsButton(
            text: '2 Перейти в настройки', action: AppSettings.openAppSettings),
        SettingsButton(
            text: '3 Перейти в настройки',
            action: AppSettings.openBatteryOptimizationSettings),
        SettingsButton(
            text: '4 Перейти в настройки',
            action: AppSettings.openBluetoothSettings),
        SettingsButton(
            text: '5 Перейти в настройки',
            action: AppSettings.openDataRoamingSettings),
        SettingsButton(
            text: '6 Перейти в настройки',
            action: AppSettings.openDateSettings),
        SettingsButton(
            text: '7 Перейти в настройки',
            action: AppSettings.openDevelopmentSettings),
        SettingsButton(
            text: '8 Перейти в настройки',
            action: AppSettings.openDeviceSettings),
        SettingsButton(
            text: '9 Перейти в настройки',
            action: AppSettings.openDisplaySettings),
        SettingsButton(
            text: '10 Перейти в настройки',
            action: AppSettings.openHotspotSettings),
        SettingsButton(
            text: '11 Перейти в настройки',
            action: AppSettings.openInternalStorageSettings),
        SettingsButton(
            text: '12 Перейти в настройки',
            action: AppSettings.openLocationSettings),
        SettingsButton(
            text: '13 Перейти в настройки',
            action: AppSettings.openLockAndPasswordSettings),
        SettingsButton(
            text: '14 Перейти в настройки',
            action: AppSettings.openNFCSettings),
        SettingsButton(
            text: '15 Перейти в настройки',
            action: AppSettings.openNotificationSettings),
        SettingsButton(
            text: '16 Перейти в настройки',
            action: AppSettings.openSecuritySettings),
        SettingsButton(
            text: '17 Перейти в настройки',
            action: AppSettings.openSoundSettings),
        SettingsButton(
            text: '18 Перейти в настройки',
            action: AppSettings.openVPNSettings),
        SettingsButton(
          text: '19 Перейти в настройки',
          action: AppSettings.openWIFISettings,
        ),
        SettingsButton(
          text: '20 Перейти в настройки',
          action: AppSettings.openWirelessSettings,
        ),
      ],
    );
  }
}
