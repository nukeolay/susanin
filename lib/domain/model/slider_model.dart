import 'package:flutter/cupertino.dart';
import 'package:susanin/generated/l10n.dart';

class SlideModel {
  String title;
  String imagePath;
  String instruction;

  SlideModel({this.title, this.imagePath, this.instruction});

  void setTitle(String title) {
    this.title = title;
  }

  void setImagePath(String imagePath) {
    this.imagePath = imagePath;
  }

  void setInstruction(String instruction) {
    this.instruction = instruction;
  }

  String get getTitle => title;

  String get getImagePath => imagePath;

  String get getInstruction => instruction;
}

List<SlideModel> getSlides(BuildContext context) {
  List<SlideModel> slides = [];

  SlideModel slideModel1 = new SlideModel();
  slideModel1.setTitle("${S.of(context).onBoardingTitle1}");
  slideModel1.setImagePath("${S.of(context).onBoardingImage1}");
  slideModel1.setInstruction("${S.of(context).onBoardingInstruction1}");
  slides.add(slideModel1);

  SlideModel slideModel2 = new SlideModel();
  slideModel2.setTitle("${S.of(context).onBoardingTitle2}");
  slideModel2.setImagePath("${S.of(context).onBoardingImage2}");
  slideModel2.setInstruction("${S.of(context).onBoardingInstruction2}");
  slides.add(slideModel2);

  SlideModel slideModel3 = new SlideModel();
  slideModel3.setTitle("${S.of(context).onBoardingTitle3}");
  slideModel3.setImagePath("${S.of(context).onBoardingImage3}");
  slideModel3.setInstruction("${S.of(context).onBoardingInstruction3}");
  slides.add(slideModel3);

  SlideModel slideModel4 = new SlideModel();
  slideModel4.setTitle("${S.of(context).onBoardingTitle4}");
  slideModel4.setImagePath("${S.of(context).onBoardingImage4}");
  slideModel4.setInstruction("${S.of(context).onBoardingInstruction4}");
  slides.add(slideModel4);

  return slides;
}
