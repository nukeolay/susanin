import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
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
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: context.watch<SettingsCubit>().state.isDarkTheme
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor)
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Theme.of(context).scaffoldBackgroundColor),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  LocationList(topPadding: mainBarHeight + 2 * mainBarMargin),
                ],
              ),
              // BlocBuilder<MainPointerCubit, MainPointerState>(
              //     builder: (context, state) {
              //   return Center(
              //     child: Container(
              //       color: Colors.black.withOpacity(0.5),
              //       child: Text(
              //         state.toString(),
              //         style: const TextStyle(color: Colors.white),
              //       ),
              //     ),
              //   );
              // }),
              Container(
                margin: const EdgeInsets.symmetric(vertical: mainBarMargin),
                height: mainBarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MainBar(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CompassPointer(),
                        IconButton(
                          icon: const Icon(Icons.settings),
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
        ),
      ),
      floatingActionButton: const AddNewLocationButton(),
    );
  }
}
