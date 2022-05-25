import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/common_widgets/hide_button.dart';
import 'package:susanin/presentation/screens/common_widgets/custom_bottom_sheet.dart';

class CalibrateBottomSheet extends StatelessWidget {
  const CalibrateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: BlocBuilder<CompassCubit, CompassState>(builder: (context, state) {
        final compassAccuracy = state.accuracy * 180 / 3.14;
        final needCalibration = state.needCalibration;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20.0)),
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
                            ? 'low_compass_accuracy'.tr()
                            : 'normal_compass_accuracy'.tr(),
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
                            ? Theme.of(context).errorColor
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
                if (needCalibration)
                  Lottie.asset(
                    context.read<SettingsCubit>().state.isDarkTheme
                        ? 'assets/animations/calibrate_dark.json'
                        : 'assets/animations/calibrate_light.json',
                    repeat: true,
                  ),
                if (needCalibration)
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    margin: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      'compass_calibrate_instruction'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
            HideButton(text: 'button_hide'.tr()),
          ],
        );
      }),
    );
  }
}
