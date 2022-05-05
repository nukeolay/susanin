import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/pointer.dart';

class MainPointer extends StatelessWidget {
  const MainPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainPointerCubit, MainPointerState>(
      listenWhen: (previous, current) =>
          previous.locationServiceStatus !=
              LocationServiceStatus.noPermission ||
          current.locationServiceStatus != LocationServiceStatus.noPermission,
      listener: (context, state) async {
        if (state.locationServiceStatus == LocationServiceStatus.noPermission) {
          await _showGetPermissionDialog(context);
        }
      },
      builder: (context, state) {
        if (state.locationServiceStatus == LocationServiceStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state.locationServiceStatus !=
            LocationServiceStatus.loaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CircularProgressIndicator(color: Colors.red),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _onScreenText(
                    'ServiceFailure: ${state.locationServiceStatus == LocationServiceStatus.disabled}\nPermissionFailure: ${state.locationServiceStatus == LocationServiceStatus.noPermission}\nisCompassError: ${state.compassStatus == CompassStatus.failure}\nUnknownFailure: ${state.locationServiceStatus == LocationServiceStatus.unknownFailure}'),
              ),
            ],
          );
        } else {
          final result =
              'UserLat: ${state.userLongitude}\nUserLat: ${state.userLatitude}\nУгол (рад): ${state.angle.toStringAsFixed(2)}\nТочность (м): ${state.positionAccuracy.toStringAsFixed(2)}\nPoint id: ${state.activeLocationId}\nName: ${state.pointName}\nPointLat: ${state.pointLatitude}\nPointLon: ${state.pointLongitude}\nDistance: ${state.distance}\nLaxity: ${state.laxity}';
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Pointer(
                rotateAngle: state.angle,
                accuracyAngle: state.laxity,
                pointerSize: 60,
              ),
              _onScreenText(result),
            ],
          );
        }
      },
    );
  }

  Widget _onScreenText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10),
    );
  }
}

Future<bool?> _showGetPermissionDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text('Allow Susanin to access your location?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Don`t Allow'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: const Text('Allow'),
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
