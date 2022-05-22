import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HideButton extends StatelessWidget {
  final String text;
  const HideButton({required this.text, Key? key}) : super(key: key);

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
            child: Text(text),
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
              HapticFeedback.vibrate();
              Navigator.pop(context);
            }),
      ),
    );
  }
}
