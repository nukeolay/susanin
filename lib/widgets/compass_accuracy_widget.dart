import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';

class CompassAccuracy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded( //компасс
          flex: 9,
          child: Card(
            margin: EdgeInsets.only(left: padding, right: 0.0, bottom: padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
            ),
            color: Theme
                .of(context)
                .cardColor,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(padding * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${S
                        .of(context)
                        .compass}",
                    style: TextStyle(fontSize: width * 0.03, color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                  Icon(Icons.arrow_circle_up_rounded, size: width * 0.095, color: Theme
                      .of(context)
                      .primaryColor),
                ],
              ),
            ),
          ),
        ),
        Expanded( //точность GPS
          flex: 7,
          child: Card(
            margin: EdgeInsets.only(left: padding, right: 0.0, top: padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
            ),
            color: Theme
                .of(context)
                .cardColor,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(padding * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${S
                        .of(context)
                        .locationAccuracy}",
                    style: TextStyle(fontSize: width * 0.03, color: Theme
                        .of(context)
                        .primaryColor),
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "${height.truncate()} ${S
                          .of(context)
                          .metres}",
                      style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.w900, color: Theme
                          .of(context)
                          .primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
