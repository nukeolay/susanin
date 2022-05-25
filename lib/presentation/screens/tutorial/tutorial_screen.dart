import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/tutorial_cubit/tutorial_cubit.dart';
import 'package:susanin/presentation/screens/tutorial/models/slide_model.dart';
import 'package:susanin/presentation/screens/tutorial/widgets/slide_tile.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<TutorialScreen> {
  List<SlideModel> slides = [];
  int currentIndex = 0;
  PageController pageController = PageController();

  Widget pageIndexIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 5.0 : 5.0,
      width: isCurrentPage ? 15.0 : 5.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withAlpha(150),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    slides = getSlides(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light.copyWith(
                  statusBarColor: Theme.of(context).scaffoldBackgroundColor)
              : SystemUiOverlayStyle.dark.copyWith(
                  statusBarColor: Theme.of(context).scaffoldBackgroundColor),
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5.0),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: slides.length,
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return SlideTile(
                          title: slides[index].title,
                          topContent: slides[index].topContent,
                          bottomContent: slides[index].bottomContent,
                          height: size.height,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          height: Platform.isIOS ? 70.0 : 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < slides.length; i++)
                    currentIndex == i
                        ? pageIndexIndicator(true)
                        : pageIndexIndicator(false),
                ],
              ),
              currentIndex != slides.length - 1
                  ? GestureDetector(
                      child: Text(
                        'button_next'.tr(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 21.0),
                      ),
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        pageController.animateToPage(currentIndex + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      })
                  : GestureDetector(
                      child: Text('button_start'.tr(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 21.0)),
                      onTap: () {
                        HapticFeedback.heavyImpact();
                        context.read<TutorialCubit>().start();
                        Navigator.of(context).pushReplacementNamed(Routes.home);
                      }),
            ],
          ),
        ));
  }
}
