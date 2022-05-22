import 'package:flutter/material.dart';

class TutorialText extends StatelessWidget {
  final String text;
  final bool isErrorText;
  const TutorialText(
    this.text, {
    this.isErrorText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.05;
    return Text(
      text,
      style: TextStyle(
        color: isErrorText
            ? Theme.of(context).errorColor
            : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
        fontSize: fontSize,
        height: 1.1,
      ),
    );
  }
}
