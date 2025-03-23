import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/navigation/routes.dart';
import '../../../../../../internal/cubit/app_settings_cubit.dart';
import '../../../../../common/snackbar_error_handler.dart';
import '../cubit/main_pointer_cubit.dart';
import 'main_pointer.dart';
import 'no_compass_pointer.dart';

class MainBarForeground extends StatelessWidget {
  const MainBarForeground({super.key});

  @override
  Widget build(BuildContext context) {
    final isFailure = context.select<MainPointerCubit, bool>(
      (cubit) => cubit.state.isFailure,
    );
    return Dismissible(
      key: const ValueKey('main_pointer'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection dismissDirection) {
        unawaited(HapticFeedback.heavyImpact());
        unawaited(
          context.read<AppSettingsCubit>().toggleTheme().onError(
            SnackBarErrorHandler(context).onError,
          ),
        );
        return Future.value(false);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color:
              isFailure
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 4.0,
              spreadRadius: 0.5,
              offset: const Offset(-2, 3.0),
            ),
          ],
        ),
        child: const _MainBarForeground(),
      ),
    );
  }
}

class _MainBarForeground extends StatelessWidget {
  const _MainBarForeground();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPointerCubit, MainPointerState>(
      builder: (context, state) {
        if (state.isFailure) {
          return MainPointerFailure(state: state);
        }
        if (state.compassStatus.isFailure) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              unawaited(HapticFeedback.heavyImpact());
              GoRouter.of(context).go(Routes.location(state.activePlace.id));
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
            unawaited(HapticFeedback.heavyImpact());
            GoRouter.of(context).go(Routes.location(state.activePlace.id));
          },
          child: MainPointerDefault(state: state),
        );
      },
    );
  }
}
