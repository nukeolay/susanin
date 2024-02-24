import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/custom_snackbar.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    required this.value,
    required this.title,
    super.key,
  });

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
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
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
          HapticFeedback.heavyImpact();
          final snackBar = CustomSnackBar(
            content: Text('copied'.tr(), textAlign: TextAlign.center),
          );
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
          Clipboard.setData(
            ClipboardData(text: value),
          );
        },
      ),
    );
  }
}
