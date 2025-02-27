import 'package:flutter/material.dart';

class TutorialText extends StatelessWidget {
  const TutorialText(this.text, {this.isError = false, super.key});

  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.045;
    return Text(
      text,
      style: TextStyle(
        color:
            isError
                ? Theme.of(context).colorScheme.error
                : Theme.of(
                  context,
                ).textTheme.bodyLarge!.color!.withValues(alpha: 0.7),
        fontSize: fontSize,
        height: 1.1,
      ),
    );
  }
}
