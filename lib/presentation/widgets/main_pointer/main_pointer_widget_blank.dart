import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:susanin/domain/bloc/data/data_bloc.dart';
import 'package:susanin/domain/bloc/data/data_events.dart';
import 'package:susanin/domain/bloc/data/data_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/theme/config.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/presentation/theme/custom_theme.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_empty_list.dart';
import 'package:susanin/presentation/widgets/main_pointer/main_pointer_widget_ok.dart';

class MainPointerBlank extends StatelessWidget {
  Widget optionWidget;

  MainPointerBlank(this.optionWidget);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final DataBloc dataBloc = BlocProvider.of<DataBloc>(context);
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    return Card(
      margin: EdgeInsets.only(left: 0.0, right: padding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      color: Theme.of(context).accentColor,
      elevation: 5,
      child: Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.2,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Theme.of(context).accentColor),
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: 2 * padding, top: padding, bottom: padding),
            child: optionWidget,
          ),
        ),
        secondaryActions: <Widget>[
          Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                color: Theme.of(context).primaryColor),
            child: IconSlideAction(
              color: Theme.of(context).primaryColor,
              icon: Icons.brightness_6,
              onTap: () =>
                  dataBloc.add(DataEventPressedToggleTheme()), //todo перенести события и состояния из ДатаБлок в ЛокейшнБлок, оставить один Блок
            ),
          ),
        ],
      ),
    );
  }
}
