import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/location/domain/entities/position.dart';
import 'package:susanin/presentation/common/pointer.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/cubit/main_pointer_cubit.dart';

class MainPointer extends StatelessWidget {
  const MainPointer({
    required this.mainText,
    required this.subText,
    this.rotateAngle = 0,
    this.accuracyAngle = 0,
    this.positionAccuracy,
    this.isShimmering = false,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    super.key,
  });

  final double rotateAngle;
  final double accuracyAngle;
  final String mainText;
  final String subText;
  final bool isShimmering;
  final double? positionAccuracy;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;

  @override
  Widget build(BuildContext context) {
    final pointerSize = MediaQuery.of(context).size.width * 0.22;
    final fontSize = MediaQuery.of(context).size.width * 0.07;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isShimmering)
          Shimmer.fromColors(
            baseColor:
                shimmerBaseColor ?? Theme.of(context).colorScheme.primary,
            highlightColor: shimmerHighlightColor ??
                Theme.of(context).colorScheme.inversePrimary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(radius: pointerSize * 0.7),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Pointer(
              rotateAngle: rotateAngle,
              arcRadius: accuracyAngle,
              radius: pointerSize,
              positionAccuracy: positionAccuracy,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              backGroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    mainText.isEmpty ? ' ' : mainText,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 200,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
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
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainPointerLoading extends StatelessWidget {
  const MainPointerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainPointer(
      isShimmering: true,
      mainText: ' ',
      subText: ' ',
    );
  }
}

class MainPointerFailure extends StatelessWidget {
  const MainPointerFailure({required this.state, super.key});
  final MainPointerState state;

  String? _subText(LocationStatus status, BuildContext context) {
    switch (status) {
      case LocationStatus.notPermitted:
        return context.s.error_geolocation_permission_short;
      case LocationStatus.disabled:
        return context.s.error_geolocation_disabled;
      case LocationStatus.unknownError:
        return context.s.error_unknown;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = state.locationServiceStatus;
    return MainPointer(
      isShimmering: true,
      shimmerBaseColor: Theme.of(context).colorScheme.error,
      shimmerHighlightColor: Theme.of(context).colorScheme.inversePrimary,
      mainText: context.s.error_title,
      subText: _subText(status, context) ?? ' ',
    );
  }
}

class MainPointerEmpty extends StatelessWidget {
  const MainPointerEmpty({required this.state, super.key});

  final MainPointerState state;

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      positionAccuracy: state.accuracy,
      mainText: context.s.empty_locations_list_header,
      subText: ' ',
    );
  }
}

class MainPointerDefault extends StatelessWidget {
  const MainPointerDefault({required this.state, super.key});

  final MainPointerState state;

  @override
  Widget build(BuildContext context) {
    return MainPointer(
      rotateAngle: state.bearing,
      accuracyAngle: state.pointerArc,
      positionAccuracy: state.accuracy,
      mainText: state.distance.toInt().toDistanceString(context),
      subText: state.placeName,
    );
  }
}
