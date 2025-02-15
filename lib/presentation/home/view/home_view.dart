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
    return const BlurredScaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainBar(),
              SideBar(),
            ],
          ),
        ),
      ),
      body: LocationList(),
      floatingActionButton: AddNewLocationButton(),
    );
  }
}
