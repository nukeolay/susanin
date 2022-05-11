import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class MainPointer extends StatelessWidget {
  final double rotateAngle;
  final double accuracyAngle;
  final PositionAccuracyStatus positionAccuracyStatus;
  final String mainText;
  final String subText;
  final bool isShimmering;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const MainPointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.positionAccuracyStatus,
    required this.mainText,
    required this.subText,
    this.isShimmering = false,
    this.shimmerBaseColor = Colors.green,
    this.shimmerHighlightColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        isShimmering
            ? Shimmer.fromColors(
                baseColor: shimmerBaseColor,
                highlightColor: shimmerHighlightColor,
                child: const Pointer(
                  rotateAngle: 0,
                  accuracyAngle: math.pi * 2,
                  pointerSize: 90,
                  foregroundColor: Colors.green,
                  backGroundColor: Colors.white,
                  centerColor: Colors.amber,
                ),
              )
            : Pointer(
                rotateAngle: rotateAngle,
                accuracyAngle: accuracyAngle,
                pointerSize: 90,
                foregroundColor: Colors.green,
                backGroundColor: Colors.white,
                centerColor:
                    positionAccuracyStatus == PositionAccuracyStatus.good
                        ? Colors.green
                        : positionAccuracyStatus == PositionAccuracyStatus.poor
                            ? Colors.amber
                            : Colors.red,
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  mainText,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Text(
                    subText,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MainPointerLoading extends StatelessWidget {
  const MainPointerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainPointer(
      rotateAngle: 0,
      accuracyAngle: math.pi * 2,
      positionAccuracyStatus: PositionAccuracyStatus.good,
      isShimmering: true,
      shimmerBaseColor: Colors.green,
      shimmerHighlightColor: Colors.white,
      mainText: '',
      subText: '',
    );
  }
}

class MainPointerFailure extends StatelessWidget {
  final MainPointerState state;
  const MainPointerFailure({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      rotateAngle: 0,
      accuracyAngle: math.pi * 2,
      positionAccuracyStatus: state.positionAccuracyStatus,
      isShimmering: true,
      shimmerBaseColor: Colors.red,
      shimmerHighlightColor: Colors.white,
      mainText: 'Ошибка',
      subText: state.locationServiceStatus == LocationServiceStatus.disabled
          ? 'GPS выключен'
          : state.locationServiceStatus == LocationServiceStatus.noPermission
              ? 'Отсутствует доступ к GPS'
              : 'Неизвестный сбой',
    );
  }
}

class MainPointerEmpty extends StatelessWidget {
  final MainPointerState state;
  const MainPointerEmpty({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      rotateAngle: 0,
      accuracyAngle: math.pi * 2,
      positionAccuracyStatus: state.positionAccuracyStatus,
      mainText: '... ... ... ...',
      subText: 'список локаций пуст',
    );
  }
}

class MainPointerDefault extends StatelessWidget {
  final MainPointerState state;
  const MainPointerDefault({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      rotateAngle: state.angle,
      accuracyAngle: state.laxity * 5,
      positionAccuracyStatus: state.positionAccuracyStatus,
      mainText: state.locations.isEmpty ? '' : state.distance,
      subText: state.pointName,
    );
  }
}
