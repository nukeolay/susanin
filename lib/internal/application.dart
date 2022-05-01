import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/routes/custom_route.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/screens/home/home_screen.dart';

class SusaninApp extends StatelessWidget {
  const SusaninApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPointerCubit>(
            create: (context) => serviceLocator<MainPointerCubit>()),
        BlocProvider<LocationsListCubit>(
            create: (context) => serviceLocator<LocationsListCubit>()),
        BlocProvider<AddLocationCubit>(
            create: (context) => serviceLocator<AddLocationCubit>()),
        BlocProvider<LocationPointValidateBloc>(
            create: (context) => serviceLocator<LocationPointValidateBloc>()),
        BlocProvider<EditLocationPointValidateBloc>(
            create: (context) =>
                serviceLocator<EditLocationPointValidateBloc>()),
        // ! TODO добавлять сюда bloc
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Susanin',
        theme: ThemeData(
          useMaterial3: true,
          //   primarySwatch: Colors.grey,
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
      ),
    );
  }
}
