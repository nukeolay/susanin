import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_pointer.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/no_compass_pointer.dart';

class MainBarForeground extends StatelessWidget {
  const MainBarForeground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MainPointerCubit>().state;
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: state.isFailure
              ? Theme.of(context).errorColor
              : Theme.of(context).colorScheme.primary,
        ),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const MainPointerLoading();
            }
            if (state.isEmpty) {
              return MainPointerEmpty(state: state);
            }
            if (state.compassStatus == CompassStatus.failure) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  HapticFeedback.vibrate();
                  Navigator.of(context).pushNamed(
                    Routes.detailedLocationInfo,
                    arguments: state.activeLocationPoint,
                  );
                },
                child: NoCompassPointer(state: state),
              );
            }
            if (state.isFailure) {
              return MainPointerFailure(state: state);
            }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                HapticFeedback.vibrate();
                Navigator.of(context).pushNamed(
                  Routes.detailedLocationInfo,
                  arguments: state.activeLocationPoint,
                );
              },
              child: MainPointerDefault(state: state),
            );
          },
        ),
      ),
    );
  }
}
