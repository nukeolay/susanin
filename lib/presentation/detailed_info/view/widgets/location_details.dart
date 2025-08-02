import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/extensions/share.dart';
import 'copy_button.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    required this.name,
    required this.latitude,
    required this.longitude,
    super.key,
  });

  final String name;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CopyButton(
                      title: context.s.latitude,
                      value: latitude.toStringAsFixed(7),
                    ),
                    CopyButton(
                      title: context.s.longitude,
                      value: longitude.toStringAsFixed(7),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            onPressed: () async {
              unawaited(HapticFeedback.heavyImpact());
              await SharePlus.instance.shareLocation(
                name: name,
                latitude: latitude,
                longitude: longitude,
              );
            },
            icon: const Icon(Icons.share_rounded),
          ),
        ),
      ],
    );
  }
}
