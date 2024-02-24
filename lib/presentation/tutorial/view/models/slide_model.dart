import 'package:flutter/material.dart';

class SlideModel {
  const SlideModel({
    required this.title,
    required this.topContent,
    required this.bottomContent,
  });

  final String title;
  final Widget topContent;
  final Widget bottomContent;
}
