import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/add_location_button/view/add_location_button.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/location_list.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/view/main_bar.dart';
import 'package:susanin/presentation/home/view/widgets/side_bar/side_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const mainBarHeight = 150.0;
    const mainBarMargin = 10.0;
    final isDarkTheme = context.select<AppSettingsCubit, bool>(
      (cubit) => cubit.state.isDarkTheme,
    );

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        // TODO remove AnnotatedRegion
        value: isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: SafeArea(
          child: Stack(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LocationList(topPadding: mainBarHeight + 2 * mainBarMargin),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: mainBarMargin),
                height: mainBarHeight,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainBar(),
                    SideBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const AddNewLocationButton(),
    );
  }
}
