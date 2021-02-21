import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_events.dart';
import 'package:susanin/domain/bloc/fab/fab_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_bloc.dart';
import 'package:susanin/domain/bloc/main_pointer/main_pointer_events.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/presentation/alerts/rename_location_alert.dart';

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width; // TODO заменить на глобальные переменные, чтобы они получались один раз
    final double height = MediaQuery.of(context).size.height;
    final double topWidgetHeight = width * 0.3;
    final double padding = width * 0.01;
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    final MainPointerBloc mainPointerBloc = BlocProvider.of<MainPointerBloc>(context);
    final FabBloc fabBloc = BlocProvider.of<FabBloc>(context);
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, lacationState) {

        if(lacationState is LocationStateLocationAddingLocation) {
          mainPointerBloc.add(MainPointerEventGetServices());
        }

        if (lacationState is LocationStateErrorEmptyLocationList) {
          mainPointerBloc.add(MainPointerEventEmptyList());
          return Text(
            "Press \"Add location\" button to save current location",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.07, color: Theme.of(context).accentColor),
          );
        } else if (lacationState is LocationStateLocationListLoaded) {
          mainPointerBloc.add(MainPointerEventSelectPoint(selectedLocationPoint: lacationState.susaninData.getSelectedLocationPoint));
          return ListView.builder(
            padding: EdgeInsets.only(top: topWidgetHeight * 0.5 + topWidgetHeight, bottom: topWidgetHeight * 0.5),
            itemCount: lacationState.susaninData.getLocationList.length ?? 0,
            addAutomaticKeepAlives: false,
            itemExtent: 80,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(4.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Slidable(
                      actionPane: SlidableBehindActionPane(),
                      actionExtentRatio: 0.2,
                      child: Container(
                        color: index == lacationState.susaninData.getSelectedLocationPointId ? Theme.of(context).accentColor : CardTheme.of(context).color,
                        child: ListTile(
                            selected: index == lacationState.susaninData.getSelectedLocationPointId ? true : false,
                            onTap: () {
                              locationBloc.add(LocationEventPressedSelectLocation(index));
                              //mainPointerBloc.add(MainPointerEventSelectPoint(selectedLocationPoint: state.susaninData.getLocationList.elementAt(index)));//todo не проверено: передаю в MainPointerBloc локуцию,чтобы от нее считать угол, расстояние и имя
                            },
                            title: Text(
                              "${lacationState.susaninData.getLocationList.elementAt(index).pointName}",
                              style: TextStyle(
                                  color: index == lacationState.susaninData.getSelectedLocationPointId
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColor),
                            ),
                            subtitle: Text(
                                "${DateFormat(S.of(context).dateFormat).format(lacationState.susaninData.getLocationList.elementAt(index).getCreationTime)}",
                                style: TextStyle(
                                    color: index == lacationState.susaninData.getSelectedLocationPointId
                                        ? Theme.of(context).primaryColorLight
                                        : Theme.of(context).primaryColor))),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Theme.of(context).errorColor,
                          icon: Icons.delete,
                          onTap: () {
                            return locationBloc.add(LocationEventPressedDeleteLocation(index));
                          },
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Rename',
                          color: Theme.of(context).accentColor.withAlpha(210),
                          icon: Icons.edit,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => RenameLocationAlert(index),
                            );
                          },
                        ),
                        IconSlideAction(
                          caption: 'Share',
                          color: Theme.of(context).accentColor.withAlpha(170),
                          icon: Icons.share,
                          onTap: () {
                            return Share.share(
                                "${lacationState.susaninData.getLocationList.elementAt(index).pointName} https://www.google.com/maps/search/?api=1&query=${lacationState.susaninData.getLocationList.elementAt(index).pointLatitude},${lacationState.susaninData.getLocationList.elementAt(index).pointLongitude}");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Text("Unhandeled error: $lacationState");
        }
      },
    );
  }
}
