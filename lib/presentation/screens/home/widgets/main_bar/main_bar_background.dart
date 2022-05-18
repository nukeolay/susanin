import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';

class MainBarBackground extends StatelessWidget {
  const MainBarBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<SettingsCubit>().state.isDarkTheme;

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
      child: isDarkTheme
          ? const Icon(
              Icons.light_mode_rounded,
              color: Colors.orange,
              size: 50,
            )
          : const Icon(
              Icons.dark_mode_rounded,
              color: Colors.yellowAccent,
              size: 50,
            ),
    );
  }
}
