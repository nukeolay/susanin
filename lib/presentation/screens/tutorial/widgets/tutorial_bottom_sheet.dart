import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/tutorial_cubit/tutorial_cubit.dart';

class TutorialBottomSheet extends StatelessWidget {
  final PageController pageController;
  final int currentIndex;
  final int slideQuantity;
  const TutorialBottomSheet({
    required this.pageController,
    required this.currentIndex,
    required this.slideQuantity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      height: Platform.isIOS ? 70.0 : 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < slideQuantity; i++)
                PageIndicator(isCurrentPage: currentIndex == i)
            ],
          ),
          currentIndex != slideQuantity - 1
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
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool isCurrentPage;
  const PageIndicator({
    required this.isCurrentPage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 5.0,
      width: isCurrentPage ? 15.0 : 5.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withAlpha(150),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
