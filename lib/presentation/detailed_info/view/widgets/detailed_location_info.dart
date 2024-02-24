import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:susanin/presentation/common/widgets/pointer.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/location_details.dart';

class DetailedLocationInfo extends StatelessWidget {
  const DetailedLocationInfo({
    required this.hasCompass,
    required this.angle,
    required this.pointerArc,
    required this.accuracy,
    required this.radius,
    required this.distance,
    required this.locationName,
    required this.locationLatitude,
    required this.locationLongitude,
    required this.userLatitude,
    required this.userLongitude,
    required this.isScreenAlwaysOn,
    required this.toggleWakelock,
    super.key,
  });

  final bool hasCompass;
  final double angle;
  final double pointerArc;
  final double accuracy;
  final double radius;
  final String distance;
  final String locationName;
  final double locationLatitude;
  final double locationLongitude;
  final double userLatitude;
  final double userLongitude;
  final bool isScreenAlwaysOn;
  final VoidCallback toggleWakelock;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (hasCompass)
                      Pointer(
                        rotateAngle: angle,
                        arcRadius: pointerArc,
                        positionAccuracy: accuracy,
                        radius: radius,
                        foregroundColor:
                            Theme.of(context).colorScheme.secondary,
                        backGroundColor: Theme.of(context).cardColor,
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        distance,
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            'accuracy_details'.tr(),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                        Text(
                          'distance_meters'.tr(
                              args: [accuracy.toStringAsFixed(0).toString()]),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    LocationDetails(
                      pointName: locationName,
                      pointLatitude: locationLatitude.toStringAsFixed(7),
                      pointLongitude: locationLongitude.toStringAsFixed(7),
                    ),
                    const SizedBox(height: 10.0),
                    LocationDetails(
                      pointName: 'current_location'.tr(),
                      pointLatitude: userLatitude.toStringAsFixed(7),
                      pointLongitude: userLongitude.toStringAsFixed(7),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: toggleWakelock,
                        enableFeedback: true,
                        tooltip: 'always_on_display'.tr(),
                        icon: isScreenAlwaysOn
                            ? const Icon(Icons.lightbulb)
                            : const Icon(Icons.lightbulb_outline)),
                    IconButton(
                      onPressed: () => MapsLauncher.launchCoordinates(
                          locationLatitude, locationLongitude, locationName),
                      icon: const Icon(Icons.map_rounded),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
