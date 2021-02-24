import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_events.dart';
import 'package:susanin/domain/bloc/location_list/location_list_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_events.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_bloc.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_events.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_states.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/widgets/loading_indicator_widget.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_empty_list.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_error.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_ok.dart';

import 'main_pointer_widget_blank.dart';

class MainPointer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final MainPointerBloc mainPointerBloc = BlocProvider.of<MainPointerBloc>(context);
    final FabBloc fabBloc = BlocProvider.of<FabBloc>(context);
    final LocationListBloc locationListBloc = BlocProvider.of<LocationListBloc>(context);
    bool isStopped = false;
    return BlocBuilder<MainPointerBloc, MainPointerState>(
      builder: (context, mainPointerState) {
        print("mainPointerState: $mainPointerState");
        if (mainPointerState is MainPointerStateErrorServiceDisabled) {
          isStopped = true;
          fabBloc.add(FabEventError());
          locationListBloc.add(LocationListEventErrorServiceDisabled());
          return MainPointerBlank(MainPointerError(errorMessage: "Service Disabled"));
        }
        if (mainPointerState is MainPointerStateErrorPermissionDenied) {
          isStopped = true;
          fabBloc.add(FabEventError());
          locationListBloc.add(LocationListEventErrorPermissionDenied());
          return MainPointerBlank(MainPointerError(errorMessage: "Permission Denied"));
        }
        if (mainPointerState is MainPointerStateErrorNoCompass) {
          isStopped = true;
          fabBloc.add(FabEventError());
          locationListBloc.add(LocationListEventErrorNoCompass());
          return MainPointerBlank(MainPointerError(errorMessage: "No compass detected"));
        }
        if (mainPointerState is MainPointerStateEmptyList) {
          fabBloc.add(FabEventLoaded());
          return MainPointerBlank(MainPointerEmptyList());
        }
        if (mainPointerState is MainPointerStateLoading) {
          isStopped = true;
          mainPointerBloc.add(MainPointerEventGetServices());
          fabBloc.add(FabEventLoading());
          return MainPointerBlank(Stack(children: [
            LoadingIndicator(startColor: Theme.of(context).primaryColor, endColor: Theme.of(context).accentColor, period: 300),
            Center(child: Image.asset("assets/logo.png")),
          ]));
        }
        if (mainPointerState is MainPointerStateLoaded) {
          if (isStopped) {
            //проверяем были ли до этого стейта ошибка и если была, то делаем нормальный fab и загружаем список, иначе с каждым стетом будем загружать список и делать нормальный fab
            fabBloc.add(FabEventLoaded());
            locationListBloc.add(LocationListEventGetData());
            isStopped = false;
          }
          return MainPointerBlank(MainPointerOk());
        }
        return Text("Error. Unhandled state: $mainPointerState");
      },
    );
  }
}
