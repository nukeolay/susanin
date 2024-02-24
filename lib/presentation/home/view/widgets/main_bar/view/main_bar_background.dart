import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';

class MainBarBackground extends StatelessWidget {
  const MainBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyText1!.color,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 30.0),
      child: const _ThemeIcon(),
    );
  }
}

class _ThemeIcon extends StatelessWidget {
  const _ThemeIcon();

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );
    if (isDarkTheme) {
      return const Icon(
        Icons.light_mode_rounded,
        color: Colors.orange,
        size: 50,
      );
    }
    return const Icon(
      Icons.dark_mode_rounded,
      color: Colors.yellowAccent,
      size: 50,
    );
  }
}
