import 'package:flutter/material.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:lottie/lottie.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/slides/2_settings/tutorial_settings.dart';

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
