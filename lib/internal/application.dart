import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/routes/custom_route.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_state.dart';
import 'package:susanin/presentation/screens/home/home_screen.dart';

class SusaninApp extends StatelessWidget {
  const SusaninApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPointerCubit>(
            create: (context) => serviceLocator<MainPointerCubit>()),
        BlocProvider<CompassCubit>(
            create: (context) => serviceLocator<CompassCubit>()),
        BlocProvider<LocationsListCubit>(
            create: (context) => serviceLocator<LocationsListCubit>()),
        BlocProvider<AddLocationCubit>(
            create: (context) => serviceLocator<AddLocationCubit>()),
        BlocProvider<LocationPointValidateBloc>(
            create: (context) => serviceLocator<LocationPointValidateBloc>()),
        BlocProvider<SettingsCubit>(
            create: (context) => serviceLocator<SettingsCubit>()),
        // ! TODO добавлять сюда bloc
      ],
      child:
          BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Susanin',
          themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            primaryColor: Colors.purple,
            colorScheme: const ColorScheme.dark().copyWith(
              primary: Colors.purple,
              background: ThemeData.dark().scaffoldBackgroundColor,
              secondary: Colors.white,
              inversePrimary: Colors.white,
            ),
            iconTheme: const IconThemeData(
              color: Colors.grey,
              size: 30,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              disabledElevation: 0,
              backgroundColor: Colors.green,
            ),
            disabledColor: Colors.grey,
            hintColor: Colors.white,
            listTileTheme: const ListTileThemeData(
              selectedColor: Colors.purple,
            ),
          ),
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.green,
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.green,
              background: ThemeData.light().scaffoldBackgroundColor,
              secondary: Colors.green,
              inversePrimary: Colors.white,
            ), // colorSchemeSeed: Colors.green,
            iconTheme: const IconThemeData(
              color: Colors.grey,
              size: 30,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              disabledElevation: 0,
            ),
            cardColor: Colors.grey.shade100,
            disabledColor: Colors.grey,
            // dialogBackgroundColor: Colors.white,
            hintColor: Colors.white,
            listTileTheme: const ListTileThemeData(
              selectedColor: Colors.green,
            ),
            errorColor: Colors.red,
            // textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.red),
            // textTheme: TextTheme(sel),
            // TextSelectionThemeData.selectionColor() Colors.green,
            // colorSchemeSeed: Colors.green,
            //   scaffoldBackgroundColor: appTheme.background,
            //   fontFamily: 'Montserrat',

            //   textButtonTheme: TextButtonThemeData(
            //     style: ButtonStyle(
            //       textStyle: MaterialStateProperty.all(
            //         TextStyle(color: appTheme.buttonTextColor),
            //       ),
            //     ),
            //   ),
            //   textTheme: TextTheme(
            //     button: TextStyle(
            //       color: appTheme.buttonTextColor,
            //     ),
            //     bodyText2: TextStyle(
            //       color: appTheme.buttonTextColor,
            //     ),
            //   ),
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home:
              const HomeScreen(), // если первый запуск (провряем settings), то показать TutorialScreen
          onGenerateRoute: Routes.onGenerateRoute,
        );
      }),
    );
  }
}
