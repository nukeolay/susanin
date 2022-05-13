import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/screens/detailed_location_info/widgets/location_details.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class DetailedLocationInfoScreen extends StatelessWidget {
  const DetailedLocationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: BlocBuilder<MainPointerCubit, MainPointerState>(
                builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LayoutBuilder(builder: (context, constants) {
                    return Pointer(
                      rotateAngle: state.angle,
                      accuracyAngle: state.laxity,
                      positionAccuracy: state.positionAccuracy,
                      pointerSize: constants.maxWidth * 0.6,
                      elevation: 0,
                      foregroundColor: Theme.of(context).colorScheme.secondary,
                      backGroundColor: Theme.of(context).cardColor,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      state.distance,
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('точность определения геолокации: '),
                      Text(
                        '${state.positionAccuracy.toStringAsFixed(1)} м',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  LocationDetails(
                    pointName: state.pointName,
                    pointLatitude: state.pointLatitude.toString(),
                    pointLongitude: state.pointLongitude.toString(),
                  ),
                  const SizedBox(height: 10.0),
                  LocationDetails(
                    pointName: 'текущее местоположение',
                    pointLatitude: state.userLatitude.toString(),
                    pointLongitude: state.userLongitude.toString(),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              child: const Text('К выбору локаций'),
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
              onPressed: () {
                HapticFeedback.vibrate();
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
