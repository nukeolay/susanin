import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';
import 'package:susanin/presentation/screens/common_widgets/pointer.dart';
import 'package:susanin/presentation/screens/home/widgets/compass_pointer/calibrate_bottom_sheet.dart';

class CompassPointer extends StatelessWidget {
  const CompassPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CompassCubit, CompassState>(
        builder: (context, state) {
          if (state.status == CompassStatus.loading) {
            return Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.primary,
              highlightColor: Theme.of(context).colorScheme.inversePrimary,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(radius: 40 * 0.7),
              ),
            );
          } else if (state.status == CompassStatus.failure) {
            return IconButton(
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.noCompass),
            );
          } else {
            return GestureDetector(
              child: LoadedCompass(state: state),
              behavior: HitTestBehavior.translucent,
              onTap: (state.needCalibration && Platform.isAndroid)
                  ? () {
                      HapticFeedback.heavyImpact();
                      _showBottomSheet(context);
                    }
                  : null,
            );
          }
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CalibrateBottomSheet();
      },
    );
  }
}

class LoadedCompass extends StatefulWidget {
  final CompassState state;
  const LoadedCompass({required this.state, Key? key}) : super(key: key);

  @override
  State<LoadedCompass> createState() => _LoadedCompassState();
}

class _LoadedCompassState extends State<LoadedCompass> {
  final _animationDuration = const Duration(milliseconds: 500);
  late final Timer _timer;
  late Color _color;

  @override
  void initState() {
    _timer = Timer.periodic(_animationDuration, (timer) => _changeColor());
    _color = Colors.red;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pointer(
      rotateAngle: widget.state.angle,
      arcRadius: widget.state.accuracy,
      radius: 40,
      foregroundColor: Colors.white,
      backGroundColor: (widget.state.needCalibration && Platform.isAndroid)
          ? _color
          : Colors.grey,
    );
  }

  void _changeColor() {
    final newColor = _color == Colors.red ? Colors.grey : Colors.red;
    setState(() {
      _color = newColor;
    });
  }
}
