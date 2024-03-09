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
          Theme.of(context).primaryColor,
        );
      case secondary:
        return MaterialStateProperty.all(
          Theme.of(context).scaffoldBackgroundColor,
        );
    }
  }
}

class SusaninButton extends StatelessWidget {
  const SusaninButton({
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
    return ElevatedButton(
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
    );
  }
}
