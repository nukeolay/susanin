import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../models/slide_model.dart';
import 'tutorial_settings.dart';

class SettingSlide extends SlideModel {
  SettingSlide(BuildContext context)
      : super(
          topContent: Lottie.asset(
            'assets/animations/tutorial_2.json',
            repeat: true,
          ),
          title: context.s.tutorial_title_2,
          bottomContent: const TutorialSettings(),
        );
}
