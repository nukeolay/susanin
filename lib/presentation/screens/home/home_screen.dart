import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/common/add_location_button.dart';
import 'package:susanin/presentation/screens/home/widgets/location_list/locations_body.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_bar.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const mainBarHeight = 150.0;
    const mainBarMargin = 10.0;
    final isDarkTheme = context.watch<SettingsCubit>().state.isDarkTheme;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: BlocBuilder<MainPointerCubit, MainPointerState>(
          builder: (context, state) => SafeArea(
            child: Stack(
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
                    children: const [
                      MainBar(),
                      SideBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const AddNewLocationButton(),
    );
  }
}
