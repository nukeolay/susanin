import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/internal/service_locator.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';
import 'package:susanin/presentation/screens/home/widgets/main_bar/pointer.dart';

class MainBar extends StatelessWidget {
  const MainBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 30.0),
            child: const Icon(
              Icons.dark_mode_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
          Dismissible(
            key: const ValueKey('main_pointer'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (DismissDirection dismissDirection) {
              return Future.value(false);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Material(
                elevation: 3,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.green,
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
                    if (state.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    } else if (state.isFailure) {
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
                      // } else if (state.locations.isEmpty) {
                      //   // вынести нижные виджеты в отдельный класс и продублировать тут и радиус раскрытия поменять и загрузку можно сделать
                      //   return Text('drtfyghj');
                    } else {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Pointer(
                            rotateAngle: state.angle,
                            accuracyAngle: state.laxity * 5,
                            pointerSize: 90,
                            foregroundColor: Colors.green,
                            backGroundColor: Colors.white,
                            centerColor: state.positionAccuracyStatus ==
                                    PositionAccuracyStatus.fine
                                ? Colors.green
                                : state.positionAccuracyStatus ==
                                        PositionAccuracyStatus.good
                                    ? Colors.greenAccent
                                    : state.positionAccuracyStatus ==
                                            PositionAccuracyStatus.poor
                                        ? Colors.amber
                                        : Colors.red,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    state.locations.isEmpty
                                        ? ''
                                        : state.distance,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      state.pointName,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // });
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
