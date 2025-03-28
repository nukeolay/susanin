import 'package:flutter/material.dart';

import 'susanin_button.dart';

class SusaninIconButton extends StatelessWidget {
  const SusaninIconButton({
    required this.icon,
    required this.type,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final ButtonType type;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0);
    return IconButton(
      icon: Icon(icon),
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        // backgroundColor: type.backgroundColor(context),
        foregroundColor: type.foregroundColor(context),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: radius),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
