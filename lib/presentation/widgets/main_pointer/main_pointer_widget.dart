import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_bloc.dart';
import 'package:susanin/domain/bloc/pointer/pointer_bloc.dart';
import 'package:susanin/domain/bloc/pointer/pointer_states.dart';
import 'package:susanin/domain/bloc/theme/theme_bloc.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/presentation/theme/theme.dart';
import 'package:susanin/presentation/widgets/loading_indicator_widget.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_empty_list.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_error.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_ok.dart';

import 'main_pointer_widget_blank.dart';

class MainPointer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    return BlocBuilder<PointerBloc, PointerState>(
      builder: (context, pointerState) {
        //print("pointerState: $pointerState"); //todo uncomment in debug
        if (pointerState is PointerStateErrorServiceDisabled) {
          return MainPointerBlank(MainPointerError(errorMessage: "${S.of(context).serviceDisabled}"));
        }
        if (pointerState is PointerStateErrorPermissionDenied) {
          return MainPointerBlank(MainPointerError(errorMessage: "${S.of(context).checkingPermission}"));
        }

        if (pointerState is PointerStateErrorPermissionDeniedForever) {
          return MainPointerBlank(MainPointerError(errorMessage: "${S.of(context).permissionDenied}"));
        }

        if (pointerState is PointerStateErrorNoCompass) {
          return MainPointerBlank(MainPointerError(errorMessage: "${S.of(context).noCompass}"));
        }
        if (pointerState is PointerStateEmptyList) {
          return MainPointerBlank(MainPointerEmptyList());
        }
        if (pointerState is PointerStateLoading || pointerState is PointerStateInit) {
          ThemeMode themeMode = BlocProvider.of<ThemeBloc>(context).themeMode;
          ThemeData themeData = themeMode == ThemeMode.dark ? CustomTheme.darkTheme : CustomTheme.lightTheme;
          return MainPointerBlank(LoadingIndicator(
            startColor: themeData.primaryColor,
            endColor: themeData.accentColor,
            period: 300,
          ));
        }
        if (pointerState is PointerStateLoaded) {
          return MainPointerBlank(MainPointerOk());
        }
        return Text("Error. Unhandled state: $pointerState");
      },
    );
  }
}
