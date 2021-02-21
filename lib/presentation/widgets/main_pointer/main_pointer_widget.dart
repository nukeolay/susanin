import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_events.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
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

    return BlocBuilder<MainPointerBloc, MainPointerState>(
      builder: (context, mainPointerState) {
        if (mainPointerState is MainPointerStateLoading) {
          mainPointerBloc.add(MainPointerEventGetServices());
          return MainPointerBlank(LoadingIndicator(startColor: Theme.of(context).primaryColor, endColor: Theme.of(context).accentColor, period: 300));
        } else if (mainPointerState is MainPointerStateErrorServiceDisabled) {
          fabBloc.add(FabEventError());
          return MainPointerBlank(MainPointerError(errorMessage: "Service Disabled"));
        } else if (mainPointerState is MainPointerStateErrorPermissionDenied) {
          fabBloc.add(FabEventError());
          return MainPointerBlank(MainPointerError(errorMessage: "Permission Denied"));
        } else if (mainPointerState is MainPointerStateErrorNoCompass) {
          fabBloc.add(FabEventError());
          return MainPointerBlank(MainPointerError(errorMessage: "No compass detected"));
        } else if (mainPointerState is MainPointerStateEmptyList) {
          fabBloc.add(FabEventLoaded());
          return MainPointerBlank(MainPointerEmptyList());
        } else if (mainPointerState is MainPointerStateLoaded) {
          fabBloc.add(FabEventLoaded());
          Widget widget; // если делать без ty-catch то при попытке отменить удаление точки после нескольких удалений подряд виджет рушится
          try {
            widget = MainPointerBlank(MainPointerOk());
          } catch (e) {
            widget = MainPointerBlank(MainPointerEmptyList());
          }
          return widget;
        }
        return Text("Error. Unhandled state: $mainPointerState");
      },
    );
  }
}
