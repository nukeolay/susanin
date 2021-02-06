import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:susanin/domain/bloc/data/data_states.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
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
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationStateStart) {
          locationBloc.add(LocationEventStart());
        }
        if (state is LocationStateDataLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LocationStateEmptyLocationList) {
          return Text(
            "Press \"Add location\" button to save current location",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width * 0.07, color: Theme.of(context).accentColor),
          );
        } else if (state is LocationStateLocationListLoaded) {
          return ListView.builder(
            padding: EdgeInsets.only(top: topWidgetHeight * 0.5 + topWidgetHeight, bottom: topWidgetHeight * 0.5),
            itemCount: state.susaninData.getLocationList.length,
            addAutomaticKeepAlives: false,
            itemExtent: 80,
            itemBuilder: (context, index) {
              return Card(
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                        // border: Border(
                        //   left: BorderSide(width: 16.0, color: Colors.lightBlue.shade50),
                        //   right: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
                        // ),
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  index == state.susaninData.getSelectedLocationPointId ? Theme.of(context).accentColor : CardTheme.of(context).color,
                              spreadRadius: 1.0),
                        ],
                        color: index == state.susaninData.getSelectedLocationPointId ? Theme.of(context).accentColor : CardTheme.of(context).color),
                    child: ListTile(
                        selected: index == state.susaninData.getSelectedLocationPointId ? true : false,
                        onTap: () => locationBloc.add(LocationEventPressedSelectLocation(index)),
                        //leading: index == state.susaninData.getSelectedLocationPointId ? CircleAvatar(child: Icon(Icons.my_location), backgroundColor: Theme.of(context).accentColor) : Text(""),
                        title: Text(
                          "${state.susaninData.getLocationList.elementAt(index).pointName}",
                          style: TextStyle(
                              color: index == state.susaninData.getSelectedLocationPointId
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context).primaryColor),
                        ),
                        subtitle: Text(
                            "${DateFormat(S.of(context).dateFormat).format(state.susaninData.getLocationList.elementAt(index).getCreationTime)}",
                            style: TextStyle(
                                color: index == state.susaninData.getSelectedLocationPointId
                                    ? Theme.of(context).primaryColorLight
                                    : Theme.of(context).primaryColor))),
                  ),
                  actions: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)), color: Colors.red),
                      child: IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          final snackBar = SnackBar(
                            duration: Duration(milliseconds: 3000),
                            content: Text("Location deleted!"),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                return locationBloc.add(LocationEventPressedUndoDeletion());
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print("snack");
                          return locationBloc.add(LocationEventPressedDeleteLocation(index));
                        },
                      ),
                    ),
                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Rename',
                      color: Theme.of(context).accentColor.withAlpha(120),
                      icon: Icons.edit,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => RenameLocationAlert(index),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                          color: Theme.of(context).accentColor),
                      child: IconSlideAction(
                        caption: 'Share',
                        color: Theme.of(context).accentColor,
                        icon: Icons.share,
                        onTap: () {
                          return Share.share(
                              "${state.susaninData.getLocationList.elementAt(index).pointName} https://www.google.com/maps/search/?api=1&query=${state.susaninData.getLocationList.elementAt(index).pointLatitude},${state.susaninData.getLocationList.elementAt(index).pointLongitude}");
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          print("Some error occurred $state");
          return Text("Some error occurred");
        }
      },
    );
  }
}
