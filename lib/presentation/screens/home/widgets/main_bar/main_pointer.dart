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
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  const MainPointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.positionAccuracyStatus,
    required this.mainText,
    required this.subText,
    this.isShimmering = false,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        isShimmering
            ? Shimmer.fromColors(
                baseColor: shimmerBaseColor ?? Theme.of(context).primaryColor,
                highlightColor:
                    shimmerHighlightColor ?? Theme.of(context).hintColor,
                child: Pointer(
                  rotateAngle: 0,
                  accuracyAngle: math.pi * 2,
                  pointerSize: 90,
                  foregroundColor: Theme.of(context).primaryColor,
                  backGroundColor: Colors.white,
                  centerColor: Colors.amber,
                ),
              )
            : Pointer(
                rotateAngle: rotateAngle,
                accuracyAngle: accuracyAngle,
                pointerSize: 90,
                foregroundColor: Theme.of(context).primaryColor,
                backGroundColor: Colors.white,
                centerColor:
                    positionAccuracyStatus == PositionAccuracyStatus.good
                        ? Theme.of(context).primaryColor
                        : positionAccuracyStatus == PositionAccuracyStatus.poor
                            ? Colors.amber
                            : Theme.of(context).errorColor,
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
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                Flexible(
                  child: Text(
                    subText,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).hintColor,
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
    return MainPointer(
      rotateAngle: 0,
      accuracyAngle: math.pi * 2,
      positionAccuracyStatus: PositionAccuracyStatus.good,
      isShimmering: true,
      shimmerBaseColor: Theme.of(context).primaryColor,
      shimmerHighlightColor: Theme.of(context).hintColor,
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
      shimmerBaseColor: Theme.of(context).errorColor,
      shimmerHighlightColor: Theme.of(context).hintColor,
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
      mainText: 'список локаций пуст',
      subText: '',
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
