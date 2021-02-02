import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/app_data_old.dart';
import 'file:///D:/MyApps/MyProjects/FlutterProjects/susanin/lib/old/top_info_page.dart';
import 'package:provider/provider.dart';

class NoLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ApplicationData _applicationData = context.watch<ApplicationData>();
    // Position _position = context.watch<Position>();
    // double _compassDirection = context.watch<double>();
    // double compass = _compassDirection ?? 0;
    Position _myCurrentPosition = context.watch<Position>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TopInfoPage(),
                    Text(S.of(context).warningNoSavedLocations,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(S.of(context).warningPleasePress,
                                    style: TextStyle(fontSize: 20)),
                                CircleAvatar(
                                    child: Icon(Icons.add_location_alt,
                                        color: Colors.white),
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
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0, bottom: 70.0),
                              child: Text(
                                S.of(context).warningInstruction,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_location_alt,
          size: 30,
        ),
        onPressed: () {
          context.read<ApplicationData>().setCurrentLocationAsPoint(
              _myCurrentPosition, S.of(context).locationNameTemplate);
        },
        elevation: 10,
        tooltip: S.of(context).addCurrentLocation,
      ),
    );
  }
}
