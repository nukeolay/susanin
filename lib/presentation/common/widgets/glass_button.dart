import 'dart:ui';

import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary;

  MaterialStateProperty<Color?>? foregroundColor(BuildContext context) {
    switch (this) {
      case primary:
        return MaterialStateProperty.all(
          Theme.of(context).colorScheme.inversePrimary,
        );
      case secondary:
        return null;
    }
  }

  MaterialStateProperty<Color?>? backgroundColor(BuildContext context) {
    switch (this) {
      case primary:
        return MaterialStateProperty.all(
          Theme.of(context).primaryColor.withOpacity(0.8),
        );
      case secondary:
        return MaterialStateProperty.all(
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
        );
    }
  }
}

class GlassButton extends StatelessWidget {
  const GlassButton({
    required this.label,
    required this.type,
    this.onPressed,
    super.key,
  });

  final String label;
  final ButtonType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0);
    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: type.backgroundColor(context),
            foregroundColor: type.foregroundColor(context),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: radius),
            ),
          ),
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
