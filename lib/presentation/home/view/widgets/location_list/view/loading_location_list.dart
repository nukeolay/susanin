import 'package:flutter/material.dart';

class LoadingLocationList extends StatelessWidget {
  const LoadingLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
