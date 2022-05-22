import 'package:flutter/material.dart';

class SlideModel {
  final String title;
  final String imagePath;
  final String instruction;

  SlideModel(
      {required this.title,
      required this.imagePath,
      required this.instruction});
}

List<SlideModel> getSlides(BuildContext context) {
  List<SlideModel> slides = [];

  SlideModel slideModel1 = SlideModel(
    imagePath: 'assets/icon/icon.png',
    title: 'Title 1',
    instruction: 'Instruction text 1',
  );
  slides.add(slideModel1);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel2 = SlideModel(
    imagePath: 'assets/icon/icon.png',
    title: 'Title 1',
    instruction: 'Instruction text 1',
  );
  slides.add(slideModel2);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel3 = SlideModel(
    imagePath: 'assets/icon/icon.png',
    title: 'Title 1',
    instruction: 'Instruction text 1',
  );
  slides.add(slideModel3);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  return slides;
}
