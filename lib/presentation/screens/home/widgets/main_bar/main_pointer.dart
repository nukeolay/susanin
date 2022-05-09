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
                  overflow: TextOverflow.ellipsis,
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
