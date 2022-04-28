import 'package:flutter/material.dart';
import 'package:susanin/presentation/screens/home/widgets/add_location_button.dart';
import 'package:susanin/presentation/screens/home/widgets/location_list.dart';
import 'package:susanin/presentation/screens/home/widgets/main_pointer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  MainPointer(),
                ],
              ),
              const LocationList(),
            ],
          ),
        ),
        floatingActionButton: const AddNewLocationButton(),
      ),
    );
  }
}
