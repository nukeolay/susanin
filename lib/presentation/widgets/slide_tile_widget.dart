import 'package:flutter/material.dart';
import 'dart:io';

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Image.asset(imagePath, width: width * 0.9),
            Container(
              alignment: AlignmentDirectional.bottomStart,
              padding: EdgeInsets.only(top:20.0, bottom: 10.0),
              child: Text(
                "$title",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Text("$instruction", textAlign: TextAlign.left, style: TextStyle(fontSize: height * 0.025, color: Colors.white)),
            SizedBox(height: Platform.isIOS ? 70.0 : 60.0)
          ],
        ),
      ),
    );
  }
}
