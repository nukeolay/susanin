import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/hollywood_pointer.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/tutorial_settings.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/tutorial_text.dart';

class SlideModel {
  final String title;
  final Widget topContent;
  final Widget bottomContent;

  SlideModel(
      {required this.title,
      required this.topContent,
      required this.bottomContent});
}

List<SlideModel> getSlides(BuildContext context) {
  List<SlideModel> slides = [];

  SlideModel slideModel1 = SlideModel(
    topContent: Lottie.asset('assets/animations/tutorial_1.json', repeat: true),
    title: 'tutorial_title_1'.tr(),
    bottomContent: TutorialText('tutorial_text_1'.tr()),
  );
  slides.add(slideModel1);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel2 = SlideModel(
    topContent: Lottie.asset('assets/animations/tutorial_2.json', repeat: true),
    title: 'tutorial_title_2'.tr(),
    bottomContent: const TutorialSettings(),
  );
  slides.add(slideModel2);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel3 = SlideModel(
    topContent: const HollywoodPointer(),
    title: 'tutorial_title_3'.tr(),
    bottomContent: TutorialText('tutorial_text_3'.tr()),
  );
  slides.add(slideModel3);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  return slides;
}
