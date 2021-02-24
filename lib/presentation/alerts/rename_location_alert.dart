import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_bloc.dart';
import 'package:susanin/domain/bloc/location_list/location_list_events.dart';
import 'package:susanin/domain/bloc/location_list/location_list_states.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenameLocationAlert extends StatelessWidget {
  int index;

  RenameLocationAlert(this.index);

  @override
  Widget build(BuildContext context) {
    final LocationListBloc locationListBloc = BlocProvider.of<LocationListBloc>(context);
    final locationListState = locationListBloc.state as LocationListStateDataLoaded;
    TextEditingController _textFieldController =
        new TextEditingController(text: locationListState.susaninData.getLocationList.elementAt(index).pointName);
    return AlertDialog(
      title: Text("Rename location", style: TextStyle(color: Theme.of(context).primaryColorDark)),
      content: TextField(
        maxLength: 20,
        autofocus: false,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
            )),
        controller: _textFieldController,
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        FlatButton(
            color: Theme.of(context).errorColor,
            child: Text("Cancel"),
            onPressed: () {
              _textFieldController.clear();
              Navigator.pop(context);
            }),
        FlatButton(
          color: Theme.of(context).accentColor,
          child: Text('Rename'),
          onPressed: () {
            //print(_textFieldController.value.text);
            locationListBloc.add(LocationListEventPressedRenameLocation(index: index, newName: _textFieldController.value.text));
            _textFieldController.clear();
            Navigator.pop(context);
          },
        ),
      ],
      elevation: 7,
      shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(4.0)),
    );
  }
}
