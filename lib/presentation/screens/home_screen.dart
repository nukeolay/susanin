import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/data/data_bloc.dart';
import 'package:susanin/domain/bloc/data/data_events.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/screens/waiting_screen.dart';
import 'package:susanin/presentation/widgets/compass_accuracy_widget.dart';
import 'package:susanin/presentation/widgets/location list/location_list_widget.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/screens/waiting_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              width: width * 0.95,
              child: LocationList(),
            ),
          ), // список локаций
          Column(
            children: [
              Container(
                height: 50,
                color: Colors.transparent,
              ),
              Container(
                height: topWidgetHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: width * 0.8,
                      child: MainPointer(), // компасс сусанина
                    ),
                    Container(
                      width: width * 0.2,
                      child: CompassAccuracy(),
                    ),
                  ],
                ),
              ),
            ],
          ), // указатели
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                child: FloatingActionButton(
                  elevation: 5,
                  child: Icon(
                    Icons.add_location_alt,
                    color: Theme.of(context).secondaryHeaderColor,
                    size: 30,
                  ),
                  onPressed: () => locationBloc.add(LocationEventPressedAddNewLocation()),
                  tooltip: S.of(context).addCurrentLocation,
                ),
              ),
            ),
          ), // кнопки FAB
        ],
      ),
    );
  }
}
