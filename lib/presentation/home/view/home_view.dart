import 'package:flutter/material.dart';
import 'package:susanin/presentation/common/blurred_scaffold.dart';
import 'package:susanin/presentation/home/view/widgets/add_location_button/view/add_location_button.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/location_list.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/view/main_bar.dart';
import 'package:susanin/presentation/home/view/widgets/side_bar/side_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBarHeight = 140.0;
    final viewPadding = MediaQuery.viewPaddingOf(context);
    final mainBarTopPadding = viewPadding.top + 20;

    return BlurredScaffold(
      body: Stack(
        children: [
          LocationList(
            topPadding: mainBarHeight + mainBarTopPadding + 8,
          ),
          Positioned(
            top: mainBarTopPadding,
            left: 0,
            right: 0,
            child: const SizedBox(
              height: mainBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainBar(),
                  SideBar(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const AddNewLocationButton(),
    );
  }
}
