import 'package:easy_localization/easy_localization.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/slides/3_demo_pointer/demo_pointer.dart';
import 'package:susanin/presentation/tutorial/view/widgets/tutorial_text.dart';

class DemoPointerSlide extends SlideModel {
  DemoPointerSlide()
      : super(
          topContent: const DemoPointer(),
          title: 'tutorial_title_3'.tr(),
          bottomContent: TutorialText('tutorial_text_3'.tr()),
        );
}
