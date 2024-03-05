import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/cubit/main_pointer_cubit.dart';

class NoCompassPointer extends StatelessWidget {
  const NoCompassPointer({required this.state, super.key});

  final MainPointerState state;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.08;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'no_compass_distance_to_point'.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize * 0.4,
              ),
            ),
            Text(
              state.distance.toInt().toDistanceString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            state.placeName,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: fontSize * 0.5,
            ),
          ),
        ),
        Divider(color: Theme.of(context).colorScheme.inversePrimary),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'no_compass_accuracy'.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize * 0.4,
              ),
            ),
            Text(
              'distance_meters'.tr(args: [state.accuracy.toStringAsFixed(0)]),
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize * 0.7,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
