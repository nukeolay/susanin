import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/domain/bloc/compass/compass_bloc.dart';
import 'package:susanin/domain/bloc/compass/compass_states.dart';
import 'package:susanin/domain/bloc/data/data_bloc.dart';
import 'package:susanin/domain/bloc/data/data_events.dart';
import 'package:susanin/domain/bloc/data/data_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
import 'package:susanin/domain/bloc/position/position_bloc.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/theme/config.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/theme/custom_theme.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
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
    //final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        return BlocBuilder<PositionBloc, PositionState>(
          builder: (context, positionState) {
            if (positionState is PositionStateErrorServiceDisabled) {
              return MainPointerBlank(MainPointerError(errorMessage: "Service Disabled"));
            } else
            if (positionState is PositionStateErrorPermissionDenied) {
              return MainPointerBlank(MainPointerError(errorMessage: "Permission Denied"));
            } else
            if (locationState is LocationStateErrorEmptyLocationList) {
              return MainPointerBlank(MainPointerEmptyList());
            } else
            if (locationState is LocationStateLocationListLoaded) {
              Widget widget; // если делать без ty-catch то при попытке отменить удаление точки после нескольких удалений подряд виджет рушится
              try {
                widget = MainPointerBlank(MainPointerOk(locationState.susaninData.getSelectedLocationPoint));
              } catch (e) {
                widget = MainPointerBlank(MainPointerEmptyList());
              }
              return widget;
            }
            print("state error = $locationState");
            return Text("ERROR");
          },
        );
      },
    );
  }
}
