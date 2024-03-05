import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class IosCompassSettings extends StatelessWidget {
  const IosCompassSettings({super.key});

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
            'ios_compass_settings_info'.tr(),
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 50.0),
      ],
    );
  }
}
