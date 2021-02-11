import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/compass/compass_bloc.dart';
import 'package:susanin/domain/bloc/compass/compass_events.dart';
import 'package:susanin/domain/bloc/compass/compass_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/position/position_bloc.dart';
import 'package:susanin/domain/bloc/position/position_events.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/generated/l10n.dart';
import 'dart:math' as math;

import 'main_pointer_widget_error.dart';

class MainPointerOk extends StatelessWidget {
  LocationPoint locationPoint;

  MainPointerOk(this.locationPoint);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final MyCompassBloc myCompassBloc = BlocProvider.of<MyCompassBloc>(context);
    final PositionBloc positionBloc = BlocProvider.of<PositionBloc>(context);

    return Container(
      height: topWidgetHeight,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<MyCompassBloc, MyCompassState>(
            builder: (context, state) {
              if (state is MyCompassStateLoading) {
                myCompassBloc.add(MyCompassEventGetCompass());
                return Padding(
                  padding: EdgeInsets.only(left: padding * 4),
                  child: SizedBox(
                    width: topWidgetHeight - 10 * padding,
                    height: topWidgetHeight - 10 * padding,
                    child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColorLight, strokeWidth: 10),
                  ),
                );
              } else if (state is MyCompassStateLoaded) {
                return StreamBuilder<CompassEvent>(
                    stream: state.compassStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return MainPointerError("Error reading heading: ${snapshot.error}");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.only(left: padding * 4),
                          child: SizedBox(
                            width: topWidgetHeight - 10 * padding,
                            height: topWidgetHeight - 10 * padding,
                            child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColorLight, strokeWidth: 10),
                          ),
                        );
                      }
                      double heading = snapshot.data.heading;
                      if (heading == null) {
                        //todo при ошибке можно отправлять Event в LocationBloc и перерисовывать весь MainPointer
                        return MainPointerError("Error reading heading: ${snapshot.error}");
                      }
                      return Transform.rotate(
                        angle: ((heading ?? 0) * (math.pi / 180) * -1),
                        child: Icon(
                          Icons.arrow_circle_up_rounded,
                          size: topWidgetHeight - 2 * padding,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      );
                    });
              } else if (state is MyCompassStateError) {
                //todo при ошибке можно отправлять Event в LocationBloc и перерисовывать весь MainPointer
                return Text("Compass error");
              } else {
                return Text("Unhandled compass Error: $state");
              }
            },
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
                      child: BlocBuilder<PositionBloc, PositionState>(
                        builder: (context, state) {
                          if (state is PositionStateLoading) {
                            positionBloc.add(PositionEventGetLocationService());
                            return CircularProgressIndicator();
                          } else if (state is PositionStateLoaded){
                            try {
                              return StreamBuilder<Position>(
                                  stream: state.positionStream,
                                  builder: (context, snapshot) {
                                    return Text(
                                      "${Geolocator.distanceBetween(
                                          snapshot.data.latitude ?? 0, snapshot.data.longitude ?? 0, locationPoint.pointLatitude,
                                          locationPoint.pointLongitude)} ${S
                                          .of(context)
                                          .metres}",
                                      //todo тут показывать расстояние, азимут передавать из LocationBloc в компасс. может имеет смысл объединить эти блоки?
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        //fontSize: topWidgetHeight * 0.4,
                                          fontWeight: FontWeight.w500,
                                          color: Theme
                                              .of(context)
                                              .secondaryHeaderColor),
                                    );
                                  }
                              );
                            } catch (e) {
                              print("Some error in PositionBloc: $e");
                              positionBloc.add(PositionEventError());
                              return CircularProgressIndicator();
                            }
                          }
                          else if (state is PositionStateErrorPermissionDenied) {
                            print("PositionStateErrorPermissionDenied");
                            return Text("Permission denied");
                          }
                          else if (state is PositionStateErrorServiceDisabled) {
                            print("PositionStateErrorServiceDisabled");
                            return Text("Service disabled");
                          }
                          else {
                            return Text("Unhandled error");
                          }
                        },
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
      ),
    );
  }
}
