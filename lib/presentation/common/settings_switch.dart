import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/extensions/extensions.dart';
import '../../features/location/domain/entities/position.dart';

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
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).cardColor,
      ),
      child: isLoading
          ? Shimmer.fromColors(
              baseColor: Theme.of(context).disabledColor,
              highlightColor: Theme.of(context).colorScheme.inversePrimary,
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(text),
                value: false,
                onChanged: null,
              ),
            )
          : SwitchListTile.adaptive(
              activeColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
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
      text: context.s.dark_theme,
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
      text: context.s.geolocation_permission,
      switchValue: isAccessGranted,
      isAlert: isAlert,
      action: isSwitchActive ? action : null,
    );
  }
}
