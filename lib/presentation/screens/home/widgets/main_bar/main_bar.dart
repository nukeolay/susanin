import 'package:flutter/material.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar_background.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar_foreground.dart';

class MainBar extends StatelessWidget {
  const MainBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: const [
          MainBarBackground(),
          MainBarForeground(),
        ],
      ),
    );
  }
}
