import 'package:flutter/material.dart';
import 'package:susanin/generated/l10n.dart';
import 'package:susanin/widgets/top_info_page.dart';

class LocationServiceDisabled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TopInfoPage(),
              Text(S.of(context).warningLocationServiceDisabled,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              Text(S.of(context).warningTurnOnLocationService,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
