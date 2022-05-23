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
    this.rotateAngle = 0,
    this.accuracyAngle = 0,
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
    final pointerSize = MediaQuery.of(context).size.width * 0.22;
    final fontSize = MediaQuery.of(context).size.width * 0.06;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isShimmering
            ? Shimmer.fromColors(
                baseColor:
                    shimmerBaseColor ?? Theme.of(context).colorScheme.primary,
                highlightColor: shimmerHighlightColor ??
                    Theme.of(context).colorScheme.inversePrimary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(radius: pointerSize * 0.7),
                ),
              )
            : Pointer(
                rotateAngle: rotateAngle,
                arcRadius: accuracyAngle,
                radius: pointerSize,
                positionAccuracy: positionAccuracy,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                backGroundColor: Theme.of(context).colorScheme.background,
              ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    mainText,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
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
                        fontSize: fontSize * 0.5,
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
      isShimmering: true,
      shimmerBaseColor: Theme.of(context).errorColor,
      shimmerHighlightColor: Theme.of(context).colorScheme.inversePrimary,
      mainText: state.mainText,
      subText: state.subText,
    );
  }
}

class MainPointerNoCompass extends StatelessWidget {
  final MainPointerState state;
  const MainPointerNoCompass({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      positionAccuracy: state.positionAccuracy,
      mainText: state.mainText,
      subText: state.subText,
    );
  }
}

class MainPointerEmpty extends StatelessWidget {
  final MainPointerState state;
  const MainPointerEmpty({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPointer(
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
      accuracyAngle: state.pointerArc,
      positionAccuracy: state.positionAccuracy,
      mainText: state.mainText,
      subText: state.subText,
    );
  }
}
