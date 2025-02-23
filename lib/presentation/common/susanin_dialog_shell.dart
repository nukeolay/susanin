import 'dart:ui';

import 'package:flutter/material.dart';

class SusaninDialogShell extends StatelessWidget {
  const SusaninDialogShell({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
