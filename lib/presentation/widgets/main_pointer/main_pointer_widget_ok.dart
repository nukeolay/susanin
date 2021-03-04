import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/pointer/pointer_bloc.dart';
import 'package:susanin/domain/bloc/pointer/pointer_states.dart';
import 'package:susanin/generated/l10n.dart';
import 'dart:math' as math;

class MainPointerOk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final pointerState = BlocProvider.of<PointerBloc>(context).state as PointerStateLoaded;
    return Container(
      height: topWidgetHeight,
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (pointerState.distance > 5)
            Transform.rotate(
              angle: (pointerState.azimuth * (math.pi / 180) * -1),
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
                      child: pointerState.distance < 5
                          ? Text(
                              "${S.of(context).lessThan5Metres}",
                              textAlign: TextAlign.right,
                              style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).secondaryHeaderColor),
                            )
                          : pointerState.distance < 500
                              ? Text(
                                  "${pointerState.distance.truncate()} ${S.of(context).metres}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).secondaryHeaderColor),
                                )
                              : Text(
                                  "${(pointerState.distance / 1000).toStringAsFixed(1)} ${S.of(context).kilometres}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).secondaryHeaderColor),
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
                            pointerState.selectedLocationPoint.pointName,
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
