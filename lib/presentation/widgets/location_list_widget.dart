import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:susanin/domain/bloc/fab/fab_bloc.dart';
import 'package:susanin/domain/bloc/fab/fab_events.dart';
import 'package:susanin/domain/bloc/location_list/location_list_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_events.dart';
import 'package:susanin/domain/bloc/location_list/location_list_states.dart';
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
    final LocationListBloc locationListBloc = BlocProvider.of<LocationListBloc>(context);
    final MainPointerBloc mainPointerBloc = BlocProvider.of<MainPointerBloc>(context);
    final FabBloc fabBloc = BlocProvider.of<FabBloc>(context);
    return BlocBuilder<LocationListBloc, LocationListState>(
      builder: (context, locationListState) {
        if (locationListState is LocationListStateInit) {
          locationListBloc.add(LocationListEventGetData());
          return Container(child: Text(""));
        }
        if (locationListState is LocationListStateErrorServiceDisabled) {
          return Text(
            "Location service disabled, please turn on location service",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.07, color: Theme.of(context).errorColor),
          );
        }
        if (locationListState is LocationListStateErrorPermissionDenied) {
          return Text(
            "Susanin does not have access to location service",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.07, color: Theme.of(context).errorColor),
          );
        }
        if (locationListState is LocationListStateErrorEmptyLocationList) {
          mainPointerBloc.add(MainPointerEventEmptyList());
          fabBloc.add(FabEventLoaded());
          return Text(
            "Press \"Add location\" button to save current location",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.07, color: Theme.of(context).accentColor),
          );
        }
        if (locationListState is LocationListStateDataLoaded) {
          fabBloc.add(FabEventLoaded());
          mainPointerBloc.add(MainPointerEventSelectPoint(selectedLocationPoint: locationListState.susaninData.getSelectedLocationPoint));
          return ListView.builder(
            padding: EdgeInsets.only(top: topWidgetHeight * 0.5 + topWidgetHeight, bottom: topWidgetHeight * 0.5),
            itemCount: locationListState.susaninData.getLocationList.length ?? 0,
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
                        color: index == locationListState.susaninData.getSelectedLocationPointId
                            ? Theme.of(context).accentColor
                            : CardTheme.of(context).color,
                        child: ListTile(
                            selected: index == locationListState.susaninData.getSelectedLocationPointId ? true : false,
                            onTap: () {
                              locationListBloc.add(LocationListEventPressedSelectLocation(index: index));
                              //mainPointerBloc.add(MainPointerEventSelectPoint(selectedLocationPoint: state.susaninData.getLocationList.elementAt(index)));//todo не проверено: передаю в MainPointerBloc локуцию,чтобы от нее считать угол, расстояние и имя
                            },
                            title: Text(
                              "${locationListState.susaninData.getLocationList.elementAt(index).pointName}",
                              style: TextStyle(
                                  color: index == locationListState.susaninData.getSelectedLocationPointId
                                      ? Theme.of(context).primaryColorLight
                                      : Theme.of(context).primaryColor),
                            ),
                            subtitle: Text(
                                "${DateFormat(S.of(context).dateFormat).format(locationListState.susaninData.getLocationList.elementAt(index).getCreationTime)}",
                                style: TextStyle(
                                    color: index == locationListState.susaninData.getSelectedLocationPointId
                                        ? Theme.of(context).primaryColorLight
                                        : Theme.of(context).primaryColor))),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Theme.of(context).errorColor,
                          icon: Icons.delete,
                          onTap: () {
                            return locationListBloc.add(LocationListEventPressedDeleteLocation(index: index));
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
                                "${locationListState.susaninData.getLocationList.elementAt(index).pointName} https://www.google.com/maps/search/?api=1&query=${locationListState.susaninData.getLocationList.elementAt(index).pointLatitude},${locationListState.susaninData.getLocationList.elementAt(index).pointLongitude}");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Text("Unhandeled locationListState: $locationListState");
      },
    );
  }
}
