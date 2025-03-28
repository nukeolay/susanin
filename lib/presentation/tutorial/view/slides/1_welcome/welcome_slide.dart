import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../models/slide_model.dart';
import '../../widgets/tutorial_text.dart';

class WelcomeSlide extends SlideModel {
  WelcomeSlide(BuildContext context)
      : super(
          topContent: Lottie.asset(
            'assets/animations/tutorial_1.json',
            repeat: true,
          ),
          title: context.s.tutorial_title_1,
          bottomContent: TutorialText(context.s.tutorial_text_1),
        );
}
