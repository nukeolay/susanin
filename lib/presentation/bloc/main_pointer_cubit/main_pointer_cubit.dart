import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/errors/location_service/failure.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_state.dart';

class MainPointerCubit extends Cubit<MainPointerState> {
  final GetPositionStream getPositionStream;
  final GetDistanceBetween getDistanceBetween;

  MainPointerCubit({
    required this.getPositionStream,
    required this.getDistanceBetween,
  }) : super(MainPointerLoading());

  void getMainPointer() {
    final failureOrPointerStream = getPositionStream();
    failureOrPointerStream.listen((event) {
      event.fold(
          (error) => emit(MainPointerError(
                message: _mapFailureToMessage(error),
              )),
          (position) => emit(
                MainPointerLoaded(position),
              ));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LocationServiceDisabledFailure:
        return 'Location Service Disabled';
      case LocationServiceDeniedFailure:
        return 'Location Service Denied';
      case LocationServiceDeniedForeverFailure:
        return 'Location Service Denied Forever';
      default:
        return 'Unexpected Error';
    }
  }
}
