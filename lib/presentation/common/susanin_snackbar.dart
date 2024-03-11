import 'package:flutter/material.dart';

class SusaninSnackBar extends SnackBar {
  const SusaninSnackBar({required super.content, super.key})
      : super(
          duration: const Duration(milliseconds: 2000),
          shape: const StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
        );
}
