import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/widgets/tutorial_text.dart';

class WelcomeSlide extends SlideModel {
  WelcomeSlide()
      : super(
          topContent: Lottie.asset(
            'assets/animations/tutorial_1.json',
            repeat: true,
          ),
          title: 'tutorial_title_1'.tr(),
          bottomContent: TutorialText('tutorial_text_1'.tr()),
        );
}
