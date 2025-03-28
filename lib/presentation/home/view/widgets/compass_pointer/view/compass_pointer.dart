import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/navigation/routes.dart';
import '../../../../../../features/compass/domain/entities/compass.dart';
import '../../../../../../features/compass/domain/repositories/compass_repository.dart';
import '../../../../../common/pointer.dart';
import '../cubit/compass_cubit.dart';
import 'calibrate_bottom_sheet.dart';

class CompassPointer extends StatelessWidget {
  const CompassPointer({super.key});

  @override
  Widget build(BuildContext context) {
    final compassRepository = context.read<CompassRepository>();
    return BlocProvider(
      create: (_) => CompassCubit(compassRepository: compassRepository)..init(),
      child: const _CompassPointerWidget(),
    );
  }
}

class _CompassPointerWidget extends StatelessWidget {
  const _CompassPointerWidget();

  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CalibrateBottomSheet();
      },
    );
  }

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
              onPressed: () => GoRouter.of(context).go(Routes.noCompass),
            );
          } else {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap:
                  (state.needCalibration && Platform.isAndroid)
                      ? () {
                        unawaited(HapticFeedback.heavyImpact());
                        _showBottomSheet(context);
                      }
                      : null,
              child: _LoadedCompass(state: state),
            );
          }
        },
      ),
    );
  }
}

class _LoadedCompass extends StatefulWidget {
  const _LoadedCompass({required this.state});
  final CompassState state;

  @override
  State<_LoadedCompass> createState() => _LoadedCompassState();
}

class _LoadedCompassState extends State<_LoadedCompass> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Pointer(
        rotateAngle: widget.state.angle,
        arcRadius: widget.state.accuracy,
        radius: 40,
        foregroundColor: Colors.white,
        backGroundColor:
            (widget.state.needCalibration && Platform.isAndroid)
                ? _color
                : Colors.grey,
      ),
    );
  }

  void _changeColor() {
    final newColor = _color == Colors.red ? Colors.grey : Colors.red;
    setState(() {
      _color = newColor;
    });
  }
}
