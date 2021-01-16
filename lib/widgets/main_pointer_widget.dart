import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';

class MainPointer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
          flex: 3,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.055,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: S.of(context).about,
                    padding: EdgeInsets.all(0.0),
                    highlightColor: Theme.of(context).accentColor,
                    icon: Icon(
                      Icons.help_outline,
                      size: width * 0.055,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.1),
                Container(
                  width: width * 0.055,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: S.of(context).tipRenameLocation,
                    padding: EdgeInsets.all(0.0),
                    highlightColor: Theme.of(context).accentColor,
                    icon: Icon(
                      Icons.edit,
                      size: width * 0.055,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.1),
                Container(
                  width: width * 0.055,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: S.of(context).tipShareLocation,
                    padding: EdgeInsets.all(0.0),
                    highlightColor: Theme.of(context).accentColor,
                    icon: Icon(
                      Icons.share,
                      size: width * 0.055,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
