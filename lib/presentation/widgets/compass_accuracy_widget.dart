import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_bloc.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_states.dart';

import 'package:susanin/generated/l10n.dart';
import 'dart:math' as math;

import 'package:susanin/presentation/widgets/loading_indicator_widget.dart';

class CompassAccuracy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return BlocBuilder<CompassAccuracyBloc, CompassAccuracyState>(builder: (context, compassAccuracyState) {
      print("compassAccuracyState: $compassAccuracyState");
      if (compassAccuracyState is CompassAccuracyStateError) {
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
      if (compassAccuracyState is CompassAccuracyStateLoaded) {
        return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            //компасс
            flex: 9,
            child: Card(
              margin: EdgeInsets.only(left: padding, right: 0.0, bottom: padding),
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${S.of(context).compass}",
                      style: TextStyle(fontSize: width * 0.03, color: Theme.of(context).primaryColor),
                    ),
                    Transform.rotate(
                      angle: ((compassAccuracyState.heading) * (math.pi / 180) * -1),
                      child: Icon(Icons.arrow_circle_up_rounded, size: width * 0.095, color: Theme.of(context).primaryColor),
                    ),
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
              color: Theme.of(context).cardColor,
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    "${S.of(context).locationAccuracy}",
                    style: TextStyle(fontSize: width * 0.03, color: Theme.of(context).primaryColor),
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      "${compassAccuracyState.currentPosition.accuracy.truncate()} ${S.of(context).metres}",
                      style: TextStyle(fontSize: width * 0.040, fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ]);
      }
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
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
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
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
              child: LoadingIndicator(startColor: Theme.of(context).cardColor, endColor: Theme.of(context).primaryColor, period: 300),
            ),
          ),
        ),
      ]);
      //return Text("Error");
    });
  }
}
