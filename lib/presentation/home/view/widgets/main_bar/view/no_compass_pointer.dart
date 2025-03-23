import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../cubit/main_pointer_cubit.dart';

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
              context.s.no_compass_distance_to_point,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize * 0.4,
              ),
            ),
            Text(
              state.distance.toInt().toDistanceString(context),
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
              context.s.no_compass_accuracy,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: fontSize * 0.4,
              ),
            ),
            Text(
              context.s.distance_meters(state.accuracy.toStringAsFixed(0)),
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
