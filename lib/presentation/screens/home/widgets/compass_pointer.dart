import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';

class CompassPointer extends StatelessWidget {
  const CompassPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompassCubit, CompassState>(
      builder: (context, state) {
        if (state.status == CompassStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.status == CompassStatus.failure) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(color: Colors.red),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _onScreenText(
                  title: 'Ошибка: ',
                  data: state.status.toString(),
                ),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Stack(
                  children: [
                    Transform.rotate(
                      alignment: Alignment.bottomCenter,
                      angle: ((state.angle + state.accuracy / 2) *
                          (math.pi / 180) *
                          -1),
                      child:
                          Container(height: 50, width: 3, color: Colors.black),
                    ),
                    Transform.rotate(
                      alignment: Alignment.bottomCenter,
                      angle: ((state.angle - state.accuracy / 2) *
                          (math.pi / 180) *
                          -1),
                      child:
                          Container(height: 50, width: 3, color: Colors.black),
                    ),
                  ],
                ),
              ),
              _onScreenText(
                  title: 'Угол: ', data: state.angle.toStringAsFixed(0)),
              _onScreenText(
                  title: 'Погрешность: ',
                  data: state.accuracy.toStringAsFixed(0)),
            ],
          );
        }
      },
    );
  }

  Widget _onScreenText({required String title, required String data}) {
    return Row(
      children: [
        Text(title),
        Text(
          data,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
