import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/location/location_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/bloc/location/location_states.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RenameLocationAlert extends StatelessWidget {
  int index;

  RenameLocationAlert(this.index);

  @override
  Widget build(BuildContext context) {
    final LocationBloc locationBloc = BlocProvider.of<LocationBloc>(context);
    return BlocBuilder<LocationBloc, LocationState>(
    //todo удалил тут <LocationBloc, LocationState>, не знаю повлияет ли это на что-то, но сюда будут приходить два блока
      builder: (context, state) {
        if (state is LocationStateLocationListLoaded) {
          TextEditingController _textFieldController = new TextEditingController(text: state.susaninData.getLocationList.elementAt(index).pointName);
          return AlertDialog(
            title: Text("Rename location", style: TextStyle(color: Theme.of(context).primaryColorDark)),
            content: TextField(
              maxLength: 20,
              autofocus: true,
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
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Text('Rename'),
                onPressed: () {
                  //print(_textFieldController.value.text);
                  locationBloc.add(LocationEventPressedRenameLocation(index, _textFieldController.value.text));
                  Navigator.pop(context);
                },
              ),
            ],
            elevation: 7,
            shape: RoundedRectangleBorder(side: BorderSide.none, borderRadius: BorderRadius.circular(4.0)),
          );
        } else {
          return Container(
            width: 0.5,
          );
        }
      },
    );
  }
}
