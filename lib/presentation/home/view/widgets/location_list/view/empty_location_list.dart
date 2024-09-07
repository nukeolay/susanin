import 'package:flutter/material.dart';
import 'package:susanin/core/extensions/extensions.dart';

class EmptyLocationList extends StatelessWidget {
  const EmptyLocationList({required this.topPadding, super.key});
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          left: 12.0,
          right: 12.0,
        ),
        child: SingleChildScrollView(
          child: Text(
            context.s.empty_locations_list,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
