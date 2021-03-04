import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/compass_accuracy/compass_accuracy_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_events.dart';
import 'package:susanin/domain/bloc/fab/fab_states.dart';
import 'package:susanin/domain/bloc/location_list/location_list_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_events.dart';
import 'package:susanin/presentation/widgets/compass_accuracy_widget.dart';
import 'package:susanin/presentation/widgets/location_list_widget.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget.dart';
import 'package:susanin/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final LocationListBloc locationListBloc = BlocProvider.of<LocationListBloc>(context);
    final CompassAccuracyBloc compassAccuracyBloc = BlocProvider.of<CompassAccuracyBloc>(context);
    final FabBloc fabBloc = BlocProvider.of<FabBloc>(context);

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
                      //Text("Test")
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
                child: BlocBuilder<FabBloc, FabState>(builder: (context, fabState) {
                  print("fabState: $fabState");
                  // в зависимости от доступности локации, показываю кнопку для добавления локаии или блокирую кнопку
                  if (fabState is FabStateError) {
                    return FloatingActionButton(
                      backgroundColor: Theme.of(context).errorColor,
                      elevation: 0,
                      child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).errorColor,
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).secondaryHeaderColor)),
                      onPressed: () {},
                    );
                  }
                  if (fabState is FabStateErrorStop) {
                    return FloatingActionButton(
                      backgroundColor: Theme.of(context).errorColor,
                      elevation: 0,
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 30,
                      ),
                      onPressed: () {},
                    );
                  }
                  if (fabState is FabStateNormal) {
                    return FloatingActionButton(
                      elevation: 5,
                      child: Icon(
                        Icons.add_location_alt,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 30,
                      ),
                      onPressed: () {
                        fabBloc.add(FabEventPressed());
                        locationListBloc.add(LocationListEventAddNewLocation(currentPosition: compassAccuracyBloc.tempCurrentPosition, defaultName: S.of(context).locationNameTemplate));
                      },
                      tooltip: S.of(context).addCurrentLocation,
                    );
                  }
                  if (fabState is FabStateLoading || fabState is FabStateInit) {
                    return FloatingActionButton(
                      backgroundColor: Theme.of(context).accentColor,
                      elevation: 0,
                      child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).accentColor,
                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).secondaryHeaderColor)),
                      onPressed: () {},
                    );
                  }
                  return Text("Unhandled fabState: $fabState");
                }),
              ),
            ),
          ), // кнопки FAB
        ],
      ),
    );
  }
}
