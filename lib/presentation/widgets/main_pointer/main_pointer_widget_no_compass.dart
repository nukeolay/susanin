import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:susanin/generated/l10n.dart';

class MainPointerNoCompass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Container(
      height: topWidgetHeight,
      alignment: Alignment.center,
      child: Text(
        "No compass detected",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: width * 0.08, color: Theme.of(context).secondaryHeaderColor),
      ),
    );
  }
}
