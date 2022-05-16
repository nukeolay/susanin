import 'package:flutter/material.dart';

class NoCompassScreen extends StatelessWidget {
  const NoCompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Компас не обнаружен'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Text('Описание проблемы'), // ! TODO fill screen with info
        ),
      ),
    );
  }
}
