import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/domain/bloc/theme/theme_bloc.dart';
import 'package:susanin/domain/bloc/theme/theme_events.dart';

class MainPointerBlank extends StatelessWidget {
  Widget optionWidget;

  MainPointerBlank(this.optionWidget);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Card(
      margin: EdgeInsets.only(left: 0.0, right: padding),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        child: Slidable(
          actionPane: SlidableBehindActionPane(),
          actionExtentRatio: 0.2,
          child: optionWidget,
          secondaryActions: <Widget>[
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                  color: Theme.of(context).primaryColor),
              child: IconSlideAction(
                color: Theme.of(context).primaryColor,
                icon: Icons.brightness_6,
                onTap: () => themeBloc.add(ThemeEventPressed()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
