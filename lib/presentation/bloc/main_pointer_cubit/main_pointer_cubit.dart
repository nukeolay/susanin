import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream getPositionStream;
  final GetDistanceBetween getDistanceBetween;
  final GetCompassStream getCompassStream;

  MainPointerCubit({
    required this.getPositionStream,
    required this.getDistanceBetween,
    required this.getCompassStream,
  }) : super(MainPointerLoading());

  void getMainPointer() {
    final failureOrPointerStream = getPositionStream();
    failureOrPointerStream.listen((event) {
      event.fold((error) {
        emit(MainPointerError(
          isServiceEnabled: error is! LocationServiceDisabledFailure,
          isPermissionGranted: error is! LocationServiceDeniedFailure,
          isCompassError: error is CompassFailure,
        ));
      },
          (position) => emit(
                MainPointerLoaded(position),
              ));
    });
  }
}
