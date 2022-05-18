import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/common/add_location_button.dart';
import 'package:susanin/presentation/screens/home/widgets/locations/location_list.dart';
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
        child: BlocListener<MainPointerCubit, MainPointerState>(
          listenWhen: (previous, current) =>
              previous.locationServiceStatus !=
                  LocationServiceStatus.noPermission ||
              current.locationServiceStatus !=
                  LocationServiceStatus.noPermission,
          listener: (context, state) async {
            if (state.locationServiceStatus ==
                LocationServiceStatus.noPermission) {
              await _showGetPermissionDialog(context);
            }
          },
          child: SafeArea(
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

Future<bool?> _showGetPermissionDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text(
            'Разрешить приложению доступ к определению геолокации?'), // Allow Susanin to access your location?
        actions: <Widget>[
          TextButton(
            child: const Text('Запретить'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text('Разрешить'),
            onPressed: () async {
              await serviceLocator<RequestPermission>()();
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
