import 'package:flutter/material.dart';
import 'package:susanin/old/alerts/rename_location_alert.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:provider/provider.dart';

class PointName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ApplicationData _applicationData = context.watch<ApplicationData>();
    String pointName = _applicationData.getLocationPoint.pointName;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("$pointName",
          style: TextStyle(fontSize: 20, color: Colors.green)),
      IconButton(
        tooltip: S.of(context).tipRenameLocation,
        onPressed: () => showDialog(
            context: context,
            builder: (_) => RenameLocationAlert(context)),
        icon: Icon(
          Icons.edit_outlined,
          color: Colors.green,
        ),
      ),
    ]);
  }
}
