import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_bloc.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_states.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/generated/l10n.dart';
import 'dart:math' as math;

import '../loading_indicator_widget.dart';
import 'main_pointer_widget_error.dart';

class MainPointerOk extends StatelessWidget {
  //LocationPoint locationPoint;//todo можно удалить, если получится получать из блока

  //MainPointerOk(this.locationPoint);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final mainPointerState = BlocProvider.of<MainPointerBloc>(context).state as MainPointerStateLoaded;
    return Container(
      height: topWidgetHeight,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (mainPointerState.getDistance() > 5)
            Transform.rotate(
              angle: (mainPointerState.getAzimuth() * (math.pi / 180) * -1),
              child: Icon(
                Icons.arrow_circle_up_rounded,
                size: topWidgetHeight - 2 * padding,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            )
          else
            Icon(
              Icons.check_circle_rounded,
              size: topWidgetHeight - 2 * padding,
              color: Theme.of(context).secondaryHeaderColor,
            ),
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
                        "${mainPointerState.getDistance()} ${S.of(context).metres}",
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
                            mainPointerState.selectedLocationPoint.pointName,
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
    );
  }
}
