import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBottomSheet extends StatelessWidget {
  const GlassBottomSheet({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.vertical(top: Radius.circular(12.0));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.only(
              top: 8.0,
              left: 8.0,
              right: 8.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              borderRadius: radius,
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
