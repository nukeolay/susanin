import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_pointer.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/no_compass_pointer.dart';

class MainBarForeground extends StatelessWidget {
  const MainBarForeground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MainPointerCubit>().state;
    return Dismissible(
      key: const ValueKey('main_pointer'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection dismissDirection) {
        HapticFeedback.heavyImpact();
        context.read<SettingsCubit>().toggleTheme();
        return Future.value(false);
      },
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4.0,
              spreadRadius: 0.5,
              offset: const Offset(-2, 3.0),
            )
          ],
        ),
        child: Builder(
          builder: (context) {
            if (state.isFailure) {
              return MainPointerFailure(state: state);
            }
            if (state.compassStatus == CompassStatus.failure) {
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  HapticFeedback.heavyImpact();
                  Navigator.of(context).pushNamed(
                    Routes.detailedLocationInfo,
                    arguments: [
                      state.activeLocationPoint,
                      PositionEntity(
                        longitude: state.userLongitude,
                        latitude: state.userLatitude,
                        accuracy: state.positionAccuracy,
                      ),
                    ],
                  );
                },
                child: NoCompassPointer(state: state),
              );
            }
            if (state.isLoading) {
              return const MainPointerLoading();
            }
            if (state.isEmpty) {
              return MainPointerEmpty(state: state);
            }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                HapticFeedback.heavyImpact();
                Navigator.of(context).pushNamed(
                  Routes.detailedLocationInfo,
                  arguments: [
                    state.activeLocationPoint,
                    PositionEntity(
                      longitude: state.userLongitude,
                      latitude: state.userLatitude,
                      accuracy: state.positionAccuracy,
                    ),
                  ],
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
