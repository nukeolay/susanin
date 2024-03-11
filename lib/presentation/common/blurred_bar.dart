import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBar extends StatelessWidget {
  const BlurredBar({required this.height, super.key});
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: SizedBox(
          height: height,
        ),
      ),
    );
  }
}
