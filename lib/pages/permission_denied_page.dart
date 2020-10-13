import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/widgets/top_info_page.dart';

class PermissionDeniedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    Text(S.of(context).warningGPSPermissionDenied,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      onPressed: () {
                        requestPermission();
                      },
                      child: Text(S.of(context).warningRequestGPSPermission),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
