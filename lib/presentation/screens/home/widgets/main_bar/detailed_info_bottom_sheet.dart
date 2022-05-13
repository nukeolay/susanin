import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/custom_bottom_sheet.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class DetailedInfoBottomSheet extends StatelessWidget {
  const DetailedInfoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: CustomBottomSheet(
        child: BlocBuilder<MainPointerCubit, MainPointerState>(
            builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.circular(20.0)),
                width: 40,
                height: 7,
              ),
              LayoutBuilder(builder: (context, constants) {
                return Pointer(
                  rotateAngle: state.angle,
                  accuracyAngle: state.laxity * 5,
                  positionAccuracy: state.positionAccuracy,
                  pointerSize: constants.maxWidth,
                  elevation: 0,
                  foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  backGroundColor: Theme.of(context).colorScheme.primary,
                  centerColor: state.positionAccuracyStatus ==
                          PositionAccuracyStatus.good
                      ? Theme.of(context).colorScheme.inversePrimary
                      : state.positionAccuracyStatus ==
                              PositionAccuracyStatus.poor
                          ? Colors.amber
                          : Colors.red,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('точность определения геолокации: '),
                  Text(
                    '${state.positionAccuracy.toStringAsFixed(1)} м',
                    style: const TextStyle(fontSize: 16),
                  ),
                  CircleAvatar(
                    radius: 10.0,
                    backgroundColor: state.positionAccuracyStatus ==
                            PositionAccuracyStatus.good
                        ? Colors.green
                        : state.positionAccuracyStatus ==
                                PositionAccuracyStatus.poor
                            ? Colors.amber
                            : Colors.red,
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
                pointName: 'ваше местоположение',
                pointLatitude: state.userLatitude.toString(),
                pointLongitude: state.userLongitude.toString(),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text('Свернуть'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                      elevation: MaterialStateProperty.all(0),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
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
              const SizedBox(height: 5.0),
            ],
          );
        }),
      ),
    );
  }
}

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
    return Container(
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
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CopyButton(title: 'широта', value: pointLatitude),
              CopyButton(title: 'долгота', value: pointLongitude),
            ],
          ),
        ],
      ),
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Column(
            children: [
              Text(
                value,
                textAlign: TextAlign.center,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.copy, color: Colors.grey),
          )
        ],
      ),
      onTap: () {
        HapticFeedback.vibrate();
        Clipboard.setData(
          ClipboardData(text: value),
        );
      },
    );
  }
}
