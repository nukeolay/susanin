import 'package:flutter/material.dart';
import 'package:susanin/core/extensions/extensions.dart';

class TutorialBottomBar extends StatelessWidget {
  const TutorialBottomBar({
    required this.currentIndex,
    required this.slideQuantity,
    required this.onNext,
    required this.onStart,
    required this.padding,
    super.key,
  });

  final int currentIndex;
  final int slideQuantity;
  final void Function() onNext;
  final void Function() onStart;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < slideQuantity; i++)
                  _PageIndicator(isCurrentPage: currentIndex == i),
              ],
            ),
            if (currentIndex != slideQuantity - 1)
              _NextButton(onTap: onNext)
            else
              _StartButton(onTap: onStart),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        context.s.button_next,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: 21.0,
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        context.s.button_start,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
          fontSize: 21.0,
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.isCurrentPage});

  final bool isCurrentPage;

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
