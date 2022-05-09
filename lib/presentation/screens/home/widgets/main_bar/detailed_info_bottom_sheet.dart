import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/pointer.dart';

class DetailedInfoBottomSheet extends StatelessWidget {
  const DetailedInfoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          left: 8.0,
          right: 8.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          color: Colors.white,
        ),
        child: BlocBuilder<MainPointerCubit, MainPointerState>(
            builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0)),
                width: 40,
                height: 7,
              ),
              LayoutBuilder(builder: (context, constants) {
                return Pointer(
                  rotateAngle: state.angle,
                  accuracyAngle: state.laxity * 5,
                  pointerSize: constants.maxWidth,
                  elevation: 0,
                  foregroundColor: Colors.green,
                  backGroundColor: Colors.white,
                  centerColor: state.positionAccuracyStatus ==
                          PositionAccuracyStatus.good
                      ? Colors.green
                      : state.positionAccuracyStatus ==
                              PositionAccuracyStatus.poor
                          ? Colors.amber
                          : Colors.red,
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('точность текущей геолокации: '),
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
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    Text(
                      state.pointName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CopyButton(
                          title: 'широта',
                          value: state.pointLatitude.toString(),
                        ),
                        CopyButton(
                          title: 'долгота',
                          value: state.pointLongitude.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    const Text(
                      'ваши координаты',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CopyButton(
                          title: 'широта',
                          value: state.userLatitude.toString(),
                        ),
                        CopyButton(
                          title: 'долгота',
                          value: state.userLongitude.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text('Свернуть'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
            ],
          );
        }),
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
      child: Row(
        children: [
          Column(
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Text(
                title,
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
