import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_pointer.dart';

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
        HapticFeedback.vibrate();
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
        ),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const MainPointerLoading();
            }
            // ! TODO implement UI for no compass devices
            // if (state.compassStatus == CompassStatus.failure) {
            //   return Text('No compass');
            // }
            if (state.isFailure) {
              return MainPointerFailure(state: state);
            }
            // if (state.locations.isEmpty) {
            //   return MainPointerEmpty(state: state);
            // }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                HapticFeedback.vibrate();
                Navigator.of(context).pushNamed(
                  Routes.detailedLocationInfo,
                  arguments: state.activeLocationPoint,
                ); // ! TODO передавать activeLocationPoint
              },
              child: MainPointerDefault(state: state),
            );
          },
        ),
      ),
    );
  }
}
