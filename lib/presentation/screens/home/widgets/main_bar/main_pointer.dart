import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class MainPointer extends StatelessWidget {
  final double rotateAngle;
  final double accuracyAngle;
  final String mainText;
  final String subText;
  final bool isShimmering;
  final double? positionAccuracy;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  const MainPointer({
    required this.rotateAngle,
    required this.accuracyAngle,
    required this.mainText,
    required this.subText,
    this.positionAccuracy,
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
                baseColor:
                    shimmerBaseColor ?? Theme.of(context).colorScheme.primary,
                highlightColor: shimmerHighlightColor ??
                    Theme.of(context).colorScheme.inversePrimary,
                child: Pointer(
                  rotateAngle: 0,
                  accuracyAngle: accuracyAngle,
                  pointerSize: 90,
                  foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                  backGroundColor: Theme.of(context).colorScheme.secondary,
                ),
              )
            : Pointer(
                rotateAngle: rotateAngle,
                accuracyAngle: accuracyAngle,
                pointerSize: 90,
                positionAccuracy: positionAccuracy,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backGroundColor: Theme.of(context).colorScheme.background,
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
                    color: Theme.of(context).colorScheme.inversePrimary,
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
                        color: Theme.of(context).colorScheme.inversePrimary),
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
      accuracyAngle: 0,
      isShimmering: true,
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
      accuracyAngle: 0,
      isShimmering: true,
      shimmerBaseColor: Theme.of(context).errorColor,
      shimmerHighlightColor: Theme.of(context).colorScheme.inversePrimary,
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
      accuracyAngle: 0,
      positionAccuracy: state.positionAccuracy,
      mainText: '',
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
      accuracyAngle: state.laxity,
      positionAccuracy: state.positionAccuracy,
      mainText: state.locations.isEmpty ? '' : state.distance,
      subText: state.pointName,
    );
  }
}
