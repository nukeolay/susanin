import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/tutorial/view/models/slide_model.dart';
import 'package:susanin/presentation/tutorial/view/widgets/slide_tile.dart';
import 'package:susanin/presentation/tutorial/view/slides/1_welcome/welcome_slide.dart';
import 'package:susanin/presentation/tutorial/view/slides/2_settings/settings_slide.dart';
import 'package:susanin/presentation/tutorial/view/slides/3_demo_pointer/demo_pointer_slide.dart';
import 'package:susanin/presentation/tutorial/view/widgets/tutorial_bottom_bar.dart';

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  @override
  State<TutorialView> createState() => _TutorialState();
}

class _TutorialState extends State<TutorialView> {
  int _currentIndex = 0;
  final _slides = <SlideModel>[];
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    _slides.addAll([WelcomeSlide(), SettingSlide(), DemoPointerSlide()]);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // TODO remove AnnotatedRegion
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
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (value) {
                      setState(() {
                        _currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return SlideTile(
                        title: _slides[index].title,
                        topContent: _slides[index].topContent,
                        bottomContent: _slides[index].bottomContent,
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
      bottomSheet: TutorialBottomBar(
        currentIndex: _currentIndex,
        slideQuantity: _slides.length,
        onNext: () {
          HapticFeedback.heavyImpact();
          _pageController.animateToPage(
            _currentIndex + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        },
        onStart: () {
          HapticFeedback.heavyImpact();
          Navigator.of(context).pushReplacementNamed(Routes.home);
        },
      ),
    );
  }
}
