import 'package:flutter/material.dart';

class LoadingDetails extends StatelessWidget {
  const LoadingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
