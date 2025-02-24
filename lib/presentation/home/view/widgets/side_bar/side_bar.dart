import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:susanin/core/navigation/routes.dart';
import 'package:susanin/presentation/home/view/widgets/compass_pointer/view/compass_pointer.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CompassPointer(),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            HapticFeedback.heavyImpact();
            GoRouter.of(context).go(Routes.settings);
          },
        ),
      ],
    );
  }
}
