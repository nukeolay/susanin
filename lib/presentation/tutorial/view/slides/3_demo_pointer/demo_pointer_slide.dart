import 'package:flutter/material.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../models/slide_model.dart';
import 'demo_pointer.dart';
import '../../widgets/tutorial_text.dart';

class DemoPointerSlide extends SlideModel {
  DemoPointerSlide(BuildContext context)
      : super(
          topContent: const DemoPointer(),
          title: context.s.tutorial_title_3,
          bottomContent: TutorialText(context.s.tutorial_text_3),
        );
}
