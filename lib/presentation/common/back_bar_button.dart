import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'susanin_button.dart';

class BackBarButton extends StatelessWidget {
  const BackBarButton({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
      child: SizedBox(
        width: double.infinity,
        child: SusaninButton(
          type: ButtonType.ghost,
          label: text,
          onPressed: () {
            unawaited(HapticFeedback.heavyImpact());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
