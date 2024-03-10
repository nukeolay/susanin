import 'dart:ui';

import 'package:flutter/material.dart';

class SusaninBottomSheet extends StatelessWidget {
  const SusaninBottomSheet({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.vertical(
      top: Radius.circular(16),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: radius,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
