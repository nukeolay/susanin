import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).accentColor,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 300, height: 300, child: Image.asset("assets/logo.png")),
                    CircularProgressIndicator(backgroundColor: Colors.white),
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
