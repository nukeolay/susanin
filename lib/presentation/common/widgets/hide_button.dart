import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HideButton extends StatelessWidget {
  const HideButton({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
        bottom: Platform.isIOS ? 20.0 : 10.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColorDark),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.inversePrimary,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            HapticFeedback.heavyImpact();
            Navigator.pop(context);
          },
          child: Text(text),
        ),
      ),
    );
  }
}
