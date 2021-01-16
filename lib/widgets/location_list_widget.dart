import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:susanin/alerts/delete_location_alert.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'package:susanin/models/location_point.dart';
import 'package:share/share.dart';

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationData _applicationData = context.watch<ApplicationData>();
    ListQueue<LocationPoint> _locationPointListStorage =
        _applicationData.getLocationPointListStorage as ListQueue<LocationPoint>;

    return ListView.builder(
      itemCount: _applicationData.getLocationPointListStorage.length,
      addAutomaticKeepAlives: false,
      itemExtent: 80,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Card(
            elevation: 1,
            child: ClipPath(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: _applicationData.getSelectedColor(index ==
                              _applicationData.getSelectedLocationPointId),
                          width: 5),
                      // bottom: BorderSide(
                      //     color: _applicationData.getSelectedColor(index ==
                      //         _applicationData.getSelectedLocationPointId),
                      //     width: 1),

                  ),
                ),
                child: ListTile(
                  selected: index == _applicationData.getSelectedLocationPointId,
                  onTap: () {
                    context.read<ApplicationData>().setSelectLocationById(index);
                  },
                  leading: SizedBox(
                    width: 99,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: _applicationData.getSelectedColor(index ==
                                _applicationData.getSelectedLocationPointId),
                          ),
                          tooltip: S.of(context).tipDeleteLocation,
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) =>
                                  DeleteLocationAlert(context, index)),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: _applicationData.getSelectedColor(index ==
                                _applicationData.getSelectedLocationPointId),
                          ),
                          tooltip: S.of(context).tipShareLocation,
                          onPressed: () {
                            return Share.share(
                                "${_locationPointListStorage.elementAt(index).pointName} https://www.google.com/maps/search/?api=1&query=${_locationPointListStorage.elementAt(index).pointLatitude},${_locationPointListStorage.elementAt(index).pointLongitude}");
                          },
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                      "${_locationPointListStorage.elementAt(index).pointName}"),
                  subtitle: Text(
                      "${DateFormat(S.of(context).dateFormat).format(_locationPointListStorage.elementAt(index).getCreationTime)}"),
                ),
              ),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3))),
            ),
          ),
        );
      },
    );
  }
}
