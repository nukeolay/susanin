import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // TODO impl SplashScreen
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
