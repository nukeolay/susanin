import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class LocationDetails extends StatelessWidget {
  final String pointName;
  final String pointLatitude;
  final String pointLongitude;

  const LocationDetails({
    Key? key,
    required this.pointName,
    required this.pointLatitude,
    required this.pointLongitude,
  }) : super(key: key);

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
                    CopyButton(title: 'latitude'.tr(), value: pointLatitude),
                    CopyButton(title: 'longitude'.tr(), value: pointLongitude),
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
                    '$pointName https://www.google.com/maps/search/?api=1&query=$pointLatitude,$pointLongitude');
              },
              icon: const Icon(Icons.share_rounded)),
        )
      ],
    );
  }
}

class CopyButton extends StatelessWidget {
  const CopyButton({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          HapticFeedback.heavyImpact();
          Clipboard.setData(
            ClipboardData(text: value),
          );
        },
      ),
    );
  }
}
