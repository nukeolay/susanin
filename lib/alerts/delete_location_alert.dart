import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/models/app_data.dart';
import 'package:susanin/models/location_point.dart';
import 'package:provider/provider.dart';

AlertDialog DeleteLocationAlert(BuildContext context, int index) {
  ApplicationData _applicationData = context.watch<ApplicationData>();
  ListQueue<LocationPoint> _locationPointListStorage =
      _applicationData.getLocationPointListStorage;
  return AlertDialog(
    title: Text(S.of(context).deleteLocation),
    content: Text("${_locationPointListStorage.elementAt(index).pointName}"),
    actions: [
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(S.of(context).cancel, style: TextStyle(fontSize: 18)),
      ),
      FlatButton(
        onPressed: () {
          context.read<ApplicationData>().deleteLocationById(index);
          Navigator.pop(context);
        },
        child: Text(S.of(context).yes, style: TextStyle(fontSize: 18)),
      ),
    ],
    elevation: 20.0,
  );
}
