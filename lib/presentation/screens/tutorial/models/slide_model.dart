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
    title: 'Привет!',
    bottomContent: const TutorialText(
        'Я помогу тебе найти путь к сохраненной локации.\n\nНикаких карт и доступа к интернету не потребуется. Только разрешение на определение геолокации и наличие компаса в телефоне.\n\nНа следующем экране ты сможешь выдать необходимые разрешения и удостовериться в наличии компаса.'),
  );
  slides.add(slideModel1);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  SlideModel slideModel2 = SlideModel(
    topContent: Lottie.asset('assets/animations/tutorial_2.json', repeat: true),
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
        'Если разрешение на доступ к геолокации выдано и компас в устройстве работает правильно, то указатель показывает прямое направление до Голливуда и расстояние до него.\n\nТеперь ты сможешь сохранять локацию на которой  находишься, чтобы найти обратный путь к ней.'),
  );
  slides.add(slideModel3);
  //-----------------------------------------------------------------------------
  //-----------------------------------------------------------------------------
  return slides;
}
