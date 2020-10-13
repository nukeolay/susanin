import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/models/app_data.dart';
import 'package:provider/provider.dart';
import 'package:susanin/widgets/screen_chooser.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Position _myCurrentPosition = context.watch<Position>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(child: ScreenChooser()),
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
          context
              .read<ApplicationData>()
              .setCurrentLocationAsPoint(_myCurrentPosition, S.of(context).locationNameTemplate);
        },
        elevation: 10,
        tooltip: S.of(context).addCurrentLocation,
      ),
    );
  }
}
