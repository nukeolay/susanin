import 'package:flutter/services.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AlertDialog RenameLocationAlert(BuildContext context) {
  ApplicationData _applicationData = context.read<ApplicationData>();
  String pointName = _applicationData.getLocationPoint.pointName;
  TextEditingController _textFieldController =
      TextEditingController(text: pointName);
  return AlertDialog(
    title: Text(S.of(context).renameLocationTitle),
    content: Form(
      child: TextFormField(
        maxLength: 25,
        maxLengthEnforced: true,
        controller: _textFieldController,
        autofocus: false,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.name,
        inputFormatters: [
          LengthLimitingTextInputFormatter(25),
        ],
      ),
    ),
    actions: [
      FlatButton(
        onPressed: () {
          _textFieldController.clear();
          //context.read<ApplicationData>().setCurrentLocationPointName(pointName);
          Navigator.pop(context);
        },
        child: Text(S.of(context).cancel, style: TextStyle(fontSize: 18)),
      ),
      FlatButton(
        onPressed: () {
          if (_textFieldController.text == "" ||
              _textFieldController.text.length > 25) {
            _textFieldController.clear();
          } else {
            context
                .read<ApplicationData>()
                .setCurrentLocationPointName(_textFieldController.text);
            _textFieldController.clear();
          }
          Navigator.pop(context);
        },
        child: Text(S.of(context).yes, style: TextStyle(fontSize: 18)),
      ),
    ],
    elevation: 20.0,
  );
}
