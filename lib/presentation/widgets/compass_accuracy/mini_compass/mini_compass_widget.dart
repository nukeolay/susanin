import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:susanin/domain/bloc/compass/compass_bloc.dart';
import 'package:susanin/domain/bloc/compass/compass_events.dart';
import 'package:susanin/domain/bloc/compass/compass_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'dart:math' as math;

import 'package:susanin/generated/l10n.dart';

class MiniCompass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final MyCompassBloc myCompassBloc = BlocProvider.of<MyCompassBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);

    return BlocBuilder<MyCompassBloc, MyCompassState>(builder: (context, state) {
      if (state is MyCompassStateLoading) {
        myCompassBloc.add(MyCompassEventGetCompass());
        return CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColorLight);
      } else if (state is MyCompassStateLoaded) {
        return Transform.rotate(
          angle: ((state.heading) * (math.pi / 180) * -1),
          child: Icon(Icons.arrow_circle_up_rounded, size: width * 0.095, color: Theme.of(context).primaryColor),
        );
      } else if (state is MyCompassStateError) {
        //todo при ошибке можно отправлять Event в LocationBloc и перерисовывать весь MainPointer "locationBloc.add(ErrorState);" и потом уже обрабатывать в предыдущих виджетах
        return Text("Compass error");
      } else {
        return Text("Unhandled compass Error: $state");
      }
    });
  }
}
