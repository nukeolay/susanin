import 'package:flutter/material.dart';

class StateFadeTransition extends StatelessWidget {
  const StateFadeTransition({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.ease,
      switchOutCurve: Curves.ease,
      duration: kThemeAnimationDuration,
      child: child,
    );
  }
}
