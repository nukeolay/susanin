import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/routes.dart';
import '../../../features/settings/domain/entities/settings.dart';
import '../../../features/settings/domain/repositories/settings_repository.dart';
import '../../common/snackbar_error_handler.dart';
import 'models/slide_model.dart';
import 'widgets/slide_tile.dart';
import 'slides/1_welcome/welcome_slide.dart';
import 'slides/2_settings/settings_slide.dart';
import 'slides/3_demo_pointer/demo_pointer_slide.dart';
import 'widgets/tutorial_bottom_bar.dart';

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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _slides.clear();
    _slides.addAll([
      WelcomeSlide(context),
      SettingSlide(context),
      DemoPointerSlide(context),
    ]);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishTutorial() async {
    final settingsRepository = context.read<SettingsRepository>();
    final settings =
        settingsRepository.settingsStream.valueOrNull ?? SettingsEntity.empty;
    if (!settings.isFirstTime) return;
    final newSettings = settings.copyWith(isFirstTime: false);
    await settingsRepository.update(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            children: [
              const SizedBox(height: 5),
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
      bottomSheet: TutorialBottomBar(
        currentIndex: _currentIndex,
        slideQuantity: _slides.length,
        onNext: () {
          unawaited(HapticFeedback.heavyImpact());
          unawaited(
            _pageController.animateToPage(
              _currentIndex + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            ),
          );
        },
        onStart: () {
          unawaited(HapticFeedback.heavyImpact());
          unawaited(
            _finishTutorial().onError(SnackBarErrorHandler(context).onError),
          );
          GoRouter.of(context).go(Routes.home);
        },
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
      ),
    );
  }
}
