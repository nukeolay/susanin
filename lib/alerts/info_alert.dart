import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';

AlertDialog InfoAlert(BuildContext context) {
  return AlertDialog(
    title: Text(S.of(context).about),
    content: Text(S.of(context).infoContent),
    actions: [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(S.of(context).close, style: TextStyle(fontSize: 18)),
      ),
    ],
    elevation: 20.0,
  );
}
