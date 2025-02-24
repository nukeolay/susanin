import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';

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
            context.s.ios_compass_settings_info,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 50.0),
      ],
    );
  }
}
