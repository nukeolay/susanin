import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final String instruction;
  final double width;
  final double height;

  SlideTile({this.title, this.imagePath, this.instruction, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "$title",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: height * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20.0),
              Image.asset(imagePath, width: width * 0.9),
              SizedBox(height: 20.0),
              Text("$instruction", textAlign: TextAlign.center, style: TextStyle(fontSize: height * 0.027, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
