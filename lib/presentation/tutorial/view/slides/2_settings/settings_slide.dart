import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/slides/2_settings/tutorial_settings.dart';

class SettingSlide extends SlideModel {
  SettingSlide()
      : super(
          topContent: Lottie.asset(
            'assets/animations/tutorial_2.json',
            repeat: true,
          ),
          title: 'tutorial_title_2'.tr(),
          bottomContent: const TutorialSettings(),
        );
}
