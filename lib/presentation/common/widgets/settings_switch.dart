import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:susanin/features/location/domain/entities/position.dart';

class SettingsSwitch extends StatelessWidget {
  const SettingsSwitch({
    required this.text,
    required this.switchValue,
    required this.action,
    this.isLoading = false,
    this.isAlert = false,
    super.key,
  });

  final String text;
  final bool switchValue;
  final Function(bool value)? action;
  final bool isLoading;
  final bool isAlert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isAlert
              ? Theme.of(context).errorColor
              : Theme.of(context).cardColor),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Theme.of(context).disabledColor,
              highlightColor: Theme.of(context).colorScheme.inversePrimary,
              child: SwitchListTile.adaptive(
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(text),
                  value: false,
                  onChanged: null),
            )
          : SwitchListTile.adaptive(
              activeColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.all(0),
              title: Text(text),
              value: switchValue,
              onChanged: action,
            ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({
    required this.isDarkTheme,
    required this.action,
    super.key,
  });
  final bool isDarkTheme;
  final Function(bool value)? action;

  @override
  Widget build(BuildContext context) {
    return SettingsSwitch(
      text: 'dark_theme'.tr(),
      switchValue: isDarkTheme,
      action: action?.call,
    );
  }
}

class LocationServiceSwitch extends StatelessWidget {
  const LocationServiceSwitch({
    required this.locationStatus,
    required this.action,
    super.key,
  });

  final LocationStatus locationStatus;
  final Function(bool value)? action;

  @override
  Widget build(BuildContext context) {
    final isAccessGranted = locationStatus.isGranted;
    final isAlert = locationStatus.isFailure;
    final isSwitchActive = locationStatus.isNotPermitted;
    return SettingsSwitch(
      isLoading: locationStatus.isLoading,
      text: 'geolocation_permission'.tr(),
      switchValue: isAccessGranted,
      isAlert: isAlert,
      action: isSwitchActive ? action : null,
    );
  }
}
