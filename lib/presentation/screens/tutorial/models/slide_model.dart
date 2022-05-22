import 'package:flutter/material.dart';
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
    topContent: Image.asset('assets/icon/icon.png'),
    title: 'Title 1',
    bottomContent: const TutorialText('Общее объяснение'),
  );
  slides.add(slideModel1);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel2 = SlideModel(
    topContent: Image.asset('assets/icon/icon.png'),
    title: 'Настройки',
    bottomContent: const TutorialSettings(),
  );
  slides.add(slideModel2);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel3 = SlideModel(
    topContent: const HollywoodPointer(),
    title: 'Вперед за Сусаниным!',
    bottomContent: const TutorialText(
        'Если разрешение на доступ к геолокации выдано и компас в устройстве работает правильно, то указатель показывает прямое направление до Голливуда и расстояние до него.\nТеперь ты сможешь сохранять локацию на которой  находишься, чтобы найти обратный путь к ней.'),
  );
  slides.add(slideModel3);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  return slides;
}
