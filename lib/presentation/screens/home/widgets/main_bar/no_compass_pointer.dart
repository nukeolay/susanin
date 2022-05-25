import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class NoCompassPointer extends StatelessWidget {
  final MainPointerState state;

  const NoCompassPointer({required this.state, Key? key}) : super(key: key);

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
              state.mainText,
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
            state.subText,
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
              'distance_meters'.tr(
                  args: [state.positionAccuracy.toStringAsFixed(0).toString()]),
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
