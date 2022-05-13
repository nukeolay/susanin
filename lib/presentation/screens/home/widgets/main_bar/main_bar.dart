import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/main_pointer.dart';

class MainBar extends StatelessWidget {
  const MainBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).textTheme.bodyText1!.color,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 30.0),
            child: context.watch<SettingsCubit>().state.isDarkTheme
                ? const Icon(
                    Icons.light_mode_rounded,
                    color: Colors.orange,
                    size: 50,
                  )
                : const Icon(
                    Icons.dark_mode_rounded,
                    color: Colors.yellowAccent,
                    size: 50,
                  ),
          ),
          Dismissible(
            key: const ValueKey('main_pointer'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection dismissDirection) {
              HapticFeedback.vibrate();
              context.read<SettingsCubit>().toggleTheme();
              return Future.value(false);
            },
            child: BlocConsumer<MainPointerCubit, MainPointerState>(
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
              builder: (context, state) {
                return Material(
                  elevation: 3,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: state.isFailure
                      ? Theme.of(context).errorColor
                      : Theme.of(context).colorScheme.primary,
                  child: Builder(
                    builder: (context) {
                      if (state.isLoading) {
                        return const MainPointerLoading();
                        // } else if (state.compassStatus == CompassStatus.failure) {
                        // ! TODO implement UI for no compass devices
                      } else if (state.isFailure) {
                        return MainPointerFailure(state: state);
                      } else if (state.locations.isEmpty) {
                        return MainPointerEmpty(state: state);
                      } else {
                        return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            HapticFeedback.vibrate();
                            Navigator.of(context)
                                .pushNamed(Routes.detailedLocationInfo);
                          },
                          child: MainPointerDefault(state: state),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
