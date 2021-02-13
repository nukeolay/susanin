import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/domain/bloc/compass/compass_bloc.dart';
import 'package:susanin/domain/bloc/compass/compass_events.dart';
import 'package:susanin/domain/bloc/compass/compass_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/position/position_bloc.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';
import 'dart:math' as math;

import 'package:susanin/generated/l10n.dart';

class Accuracy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final MyCompassBloc myCompassBloc = BlocProvider.of<MyCompassBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);

    return BlocBuilder<PositionBloc, PositionState>(builder: (context, state) {
      if (state is PositionStateLoaded) {
        return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "${S.of(context).locationAccuracy}",
            style: TextStyle(fontSize: width * 0.03, color: Theme.of(context).primaryColor),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
              "${state.currentPosition.accuracy.truncate()} ${S.of(context).metres}",
              style: TextStyle(fontSize: width * 0.040, fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor),
            ),
          ),
        ]);
      } else {
        return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "${S.of(context).locationAccuracy}",
            style: TextStyle(fontSize: width * 0.03, color: Theme.of(context).primaryColor),
          ),
          FittedBox(
            fit: BoxFit.fitHeight,
            child: LinearProgressIndicator(backgroundColor: Theme.of(context).secondaryHeaderColor),
          ),
        ]);
      }
    });
  }
}
