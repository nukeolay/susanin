import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/presentation/common/susanin_bottom_sheet.dart';
import 'package:susanin/presentation/common/back_bar_button.dart';
import 'package:susanin/presentation/home/view/widgets/compass_pointer/cubit/compass_cubit.dart';

class CalibrateBottomSheet extends StatelessWidget {
  const CalibrateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SusaninBottomSheet(
      child: BlocBuilder<CompassCubit, CompassState>(
        builder: (context, state) {
          final compassAccuracy = state.accuracy * 180 / 3.14;
          final needCalibration = state.needCalibration;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 40,
                height: 7,
              ),
              const SizedBox(height: 12.0),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          needCalibration
                              ? context.s.low_compass_accuracy
                              : context.s.normal_compass_accuracy,
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                      Text(
                        '${compassAccuracy.toStringAsFixed(0)}°',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: needCalibration
                              ? Theme.of(context).colorScheme.error
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  if (needCalibration) ...[
                    const _CalibrationAnimation(),
                    const _CalibrationInstruction(),
                  ],
                ],
              ),
              BackBarButton(text: context.s.button_hide),
            ],
          );
        },
      ),
    );
  }
}

class _CalibrationAnimation extends StatelessWidget {
  const _CalibrationAnimation();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    return Lottie.asset(
      isDarkTheme
          ? 'assets/animations/calibrate_dark.json'
          : 'assets/animations/calibrate_light.json',
      repeat: true,
    );
  }
}

class _CalibrationInstruction extends StatelessWidget {
  const _CalibrationInstruction();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      child: Text(
        context.s.compass_calibrate_instruction,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
