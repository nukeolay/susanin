import 'package:flutter/material.dart';
import 'package:susanin/presentation/theme/theme.dart';

class WaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 300, height: 300, child: Image.asset("assets/logo.png")),
                    CircularProgressIndicator(
                        backgroundColor: Colors.white, valueColor: new AlwaysStoppedAnimation<Color>(CustomTheme.lightTheme.accentColor)),
                    //Text("error: $error", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
