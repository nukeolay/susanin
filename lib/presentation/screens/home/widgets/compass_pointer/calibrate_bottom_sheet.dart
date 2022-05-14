import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/custom_bottom_sheet.dart';

class CalibrateBottomSheet extends StatelessWidget {
  const CalibrateBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      child: BlocBuilder<CompassCubit, CompassState>(builder: (context, state) {
        final compassAccuracy = state.accuracy * 180 / 3.14;
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
                    const Text(
                      'Низкая точность компаса: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${compassAccuracy.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Test text',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text('Test text')
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text('Свернуть'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColorDark),
                      elevation: MaterialStateProperty.all(0),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
            ),
          ],
        );
      }),
    );
  }
}
