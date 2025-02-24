import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/extensions/extensions.dart';
import 'copy_button.dart';

class LocationDetails extends StatelessWidget {
  const LocationDetails({
    required this.pointName,
    required this.pointLatitude,
    required this.pointLongitude,
    super.key,
  });

  final String pointName;
  final String pointLatitude;
  final String pointLongitude;

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
                  pointName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CopyButton(
                      title: context.s.latitude,
                      value: pointLatitude,
                    ),
                    CopyButton(
                      title: context.s.longitude,
                      value: pointLongitude,
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
              HapticFeedback.heavyImpact();
              await Share.share(
                '$pointName https://www.google.com/maps/search/?api=1&query=$pointLatitude,$pointLongitude',
              );
            },
            icon: const Icon(Icons.share_rounded),
          ),
        ),
      ],
    );
  }
}
