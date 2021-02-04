import 'package:flutter/material.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/generated/l10n.dart';

class MainPointerOk extends StatelessWidget {
  LocationPoint locationPoint;

  MainPointerOk(this.locationPoint);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.arrow_circle_up_rounded, size: topWidgetHeight - 2 * padding, color: Theme.of(context).secondaryHeaderColor),
        Container(
          width: width * 0.03,
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 6,
                  child: FittedBox(
                    child: Text(
                      "${width.truncate()} ${S.of(context).metres}",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          //fontSize: topWidgetHeight * 0.4,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          locationPoint.pointName,
                          style: TextStyle(
                            //fontSize: width * 0.04,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
