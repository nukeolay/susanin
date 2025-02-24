import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';

class MainBarBackground extends StatelessWidget {
  const MainBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyLarge!.color,
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
    if (context.isDarkTheme()) {
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
