import 'package:flutter/material.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/screens/home/widgets/common/add_location_button.dart';
import 'package:susanin/presentation/screens/home/widgets/compass_pointer/compass_pointer.dart';
import 'package:susanin/presentation/screens/home/widgets/locations/location_list.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mainBarHeight = 150.0;
    const mainBarMargin = 10.0;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                LocationList(topPadding: mainBarHeight + 2 * mainBarMargin),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: mainBarMargin),
              height: mainBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MainBar(),
                  Column(
                    children: [
                      const CompassPointer(),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.grey,
                          size: 30,
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Routes.settings),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: const AddNewLocationButton(),
      ),
    );
  }
}
