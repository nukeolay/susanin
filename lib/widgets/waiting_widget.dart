import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  var error;

  WaitingWidget(var e) {
    this.error = e;
  }

  @override
  Widget build(BuildContext context) {
    print("error here: $error");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/logo.png"),
                      CircularProgressIndicator(backgroundColor: Colors.white),
                      //Text("error: $error", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
