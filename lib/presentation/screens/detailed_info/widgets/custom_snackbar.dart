import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final Widget child;
  const CustomSnackBar({required this.child, Key? key})
      : super(
          key: key,
          content: child,
          duration: const Duration(milliseconds: 2000),
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
        );
}
