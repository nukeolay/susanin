import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/screens/common_widgets/hide_button.dart';
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
                      arcRadius: state.pointerArc,
                      positionAccuracy: state.positionAccuracy,
                      radius: constants.maxWidth * 0.6,
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
                      const Flexible(
                        child: Text(
                          'точность определения геолокации: ',
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
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
                    pointLatitude: state.pointLatitude.toStringAsFixed(7),
                    pointLongitude: state.pointLongitude.toStringAsFixed(7),
                  ),
                  const SizedBox(height: 10.0),
                  LocationDetails(
                    pointName: 'текущее местоположение',
                    pointLatitude: state.userLatitude.toStringAsFixed(7),
                    pointLongitude: state.userLongitude.toStringAsFixed(7),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: const HideButton(text: 'К выбору локаций'),
    );
  }
}
