import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/alerts/info_alert.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/models/app_data.dart';
import 'package:susanin/widgets/top_info_page.dart';
import 'package:provider/provider.dart';

class NoLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ApplicationData _applicationData = context.watch<ApplicationData>();
    // Position _position = context.watch<Position>();
    // double _compassDirection = context.watch<double>();
    // double compass = _compassDirection ?? 0;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     IconButton(
        //       icon: Transform.rotate(
        //         angle: -compass * (pi / 180),
        //         child: Icon(Icons.keyboard_arrow_up_outlined,
        //             size: 24, color: Colors.green),
        //       ),
        //       tooltip: S.of(context).tipCompass,
        //       onPressed: () => showDialog(
        //           context: context, builder: (_) => InfoAlert(context)),
        //     ),
        //     IconButton(
        //         icon: Icon(Icons.my_location,
        //             size: 24,
        //             color: _applicationData
        //                 .getAccuracyMarkerColor(_position.accuracy)),
        //         enableFeedback: true,
        //         tooltip:
        //             "${S.of(context).tipLocationAccuracy} ${_position.accuracy.toStringAsFixed(0)} ${S.of(context).metres}",
        //         onPressed: null)
        //   ],
        // ),
        TopInfoPage(),
        Text(S.of(context).warningNoSavedLocations,
            style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).warningPleasePress,
                style: TextStyle(fontSize: 20)),
            CircleAvatar(
                child: Icon(Icons.add_location_alt, color: Colors.white),
                radius: 20.0,
                backgroundColor: Colors.green),
          ],
        ),
        Text(
          S.of(context).warningToSaveLocation,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            S.of(context).warningInstruction,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
