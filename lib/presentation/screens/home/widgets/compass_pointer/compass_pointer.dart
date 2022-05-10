import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class CompassPointer extends StatelessWidget {
  const CompassPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CompassCubit, CompassState>(
        builder: (context, state) {
          if (state.status == CompassStatus.loading) {
            return const CircularProgressIndicator();
          } else if (state.status == CompassStatus.failure) {
            return IconButton(
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pushNamed(Routes.noCompass),
            );
          } else {
            return Pointer(
              rotateAngle: state.angle,
              accuracyAngle: state.accuracy,
              pointerSize: 40,
              foregroundColor: Colors.white,
              backGroundColor: Colors.grey,
            );
          }
        },
      ),
    );
  }
}
