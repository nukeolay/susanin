import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/compass/compass_states.dart';
import 'package:susanin/domain/bloc/position/position_bloc.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/presentation/widgets/compass_accuracy/accuracy/accuracy_widget.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:susanin/presentation/widgets/loading_indicator_widget.dart';
import 'mini_compass/mini_compass_widget.dart';

class CompassAccuracy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return BlocBuilder<PositionBloc, PositionState>(builder: (context, positionState) {
      if (positionState is PositionStateError) {
        return Container(
          height: topWidgetHeight,
          child: Card(
            margin: EdgeInsets.only(left: padding, right: 0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
            ),
            color: Theme.of(context).errorColor,
            elevation: 5,
            child: FittedBox(child: Text("!", style: TextStyle(color: Theme.of(context).secondaryHeaderColor))),
          ),
        );
      }
      if (positionState is PositionStateLoaded) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            //компасс
            flex: 9,
            child: Card(
              margin: EdgeInsets.only(left: padding, right: 0.0, bottom: padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(padding * 0.3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${S.of(context).compass}",
                      style: TextStyle(fontSize: width * 0.03, color: Theme.of(context).primaryColor),
                    ),
                    MiniCompass(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            //точность GPS
            flex: 7,
            child: Card(
              margin: EdgeInsets.only(left: padding, right: 0.0, top: padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(padding * 0.3),
                child: Accuracy(),
              ),
            ),
          ),
        ]);
      }
      //if (positionState is PositionStateLoading) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            //компасс
            flex: 9,
            child: Card(
              margin: EdgeInsets.only(left: padding, right: 0.0, bottom: padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(padding * 0.3),
                child: LoadingIndicator(startColor: Theme.of(context).cardColor, endColor: Theme.of(context).primaryColor, period: 300),
              ),
            ),
          ),
          Expanded(
            //точность GPS
            flex: 7,
            child: Card(
              margin: EdgeInsets.only(left: padding, right: 0.0, top: padding),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(padding * 0.3),
                child: LoadingIndicator(startColor: Theme.of(context).cardColor, endColor: Theme.of(context).primaryColor, period: 300),
              ),
            ),
          ),
        ]);

      //return Text("Error");
    });
  }
}
