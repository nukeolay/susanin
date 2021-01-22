import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/theme/config.dart';
import 'package:susanin/theme/custom_theme.dart';

class MainPointer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Card(
      margin: EdgeInsets.only(left: 0.0, right: padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      color: Theme.of(context).accentColor,
      elevation: 5,
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.2,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Theme.of(context).accentColor),
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
            child: Row(
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
                                  "this` 20 symbol name",
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
            ),
          ),
        ),
        secondaryActions: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)), color: Theme.of(context).primaryColor),
            child: IconSlideAction(
              color: Theme.of(context).primaryColor,
              icon: Icons.brightness_6,
              onTap: () => currentTheme.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
