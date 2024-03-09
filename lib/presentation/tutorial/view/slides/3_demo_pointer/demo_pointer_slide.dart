import 'package:flutter/material.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/slides/3_demo_pointer/demo_pointer.dart';
import 'package:susanin/presentation/tutorial/view/widgets/tutorial_text.dart';

class DemoPointerSlide extends SlideModel {
  DemoPointerSlide(BuildContext context)
      : super(
          topContent: const DemoPointer(),
          title: context.s.tutorial_title_3,
          bottomContent: TutorialText(context.s.tutorial_text_3),
        );
}
