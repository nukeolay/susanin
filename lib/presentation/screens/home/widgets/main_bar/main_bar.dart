import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar_background.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar_foreground.dart';

class MainBar extends StatelessWidget {
  const MainBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Dismissible(
        key: const ValueKey('main_pointer'),
        direction: DismissDirection.endToStart,
        confirmDismiss: (DismissDirection dismissDirection) {
          HapticFeedback.vibrate();
          context.read<SettingsCubit>().toggleTheme();
          return Future.value(false);
        },
        child: const MainBarForeground(),
        background: const MainBarBackground(),
      ),
    );
  }
}
