import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/position/position_bloc.dart';
import 'package:susanin/domain/bloc/position/position_events.dart';
import 'package:susanin/generated/l10n.dart';

class MainPointerEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final PositionBloc positionBloc = BlocProvider.of<PositionBloc>(context);
    positionBloc.add(
        PositionEventGetLocationService()); //эта строка позволяет запустить поток для определения локации, в случае если программа запущена с пустым списком
    return Container(
      padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
      height: topWidgetHeight,
      alignment: Alignment.center,
      color: Theme.of(context).accentColor,
      child: Text(
        "No saved locations",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: width * 0.08, color: Theme.of(context).secondaryHeaderColor),
      ),
    );
  }
}
