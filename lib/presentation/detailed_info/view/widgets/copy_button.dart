import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../common/susanin_snackbar.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({required this.value, required this.title, super.key});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, textAlign: TextAlign.center, softWrap: true),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          unawaited(HapticFeedback.heavyImpact());
          final snackBar = SusaninSnackBar(
            content: Text(context.s.copied, textAlign: TextAlign.center),
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
          unawaited(Clipboard.setData(ClipboardData(text: value)));
        },
      ),
    );
  }
}
