import 'package:flutter/material.dart';
import 'package:susanin/presentation/screens/home/widgets/common/add_location_button.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/compass_pointer.dart';
import 'package:susanin/presentation/screens/home/widgets/locations/location_list.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MainBar(),
                  CompassPointer(),
                ],
              ),
            ),
            const LocationList(),
          ],
        ),
        floatingActionButton: const AddNewLocationButton(),
      ),
    );
  }
}
