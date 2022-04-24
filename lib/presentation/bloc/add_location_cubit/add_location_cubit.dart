import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location_points/usecases/add_location.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';

class AddLocationCubit extends Cubit<AddLocationState> {
  final AddLocation _addLocation;
  final GetPositionStream _getPositionStream;

  AddLocationCubit({
    required AddLocation addLocation,
    required GetPositionStream getPositionStream,
  })  : _addLocation = addLocation,
        _getPositionStream = getPositionStream,
        super(const AddLocationState(
          status: AddLocationStatus.loading,
          latitude: 0,
          longitude: 0,
          pointName: '',
        )) {
    _init();
  }

  void _init() {
    final _stream = _getPositionStream();
    _stream.listen((event) {
      event.fold((failure) {
        if (state.status != AddLocationStatus.editing) {
          emit(state.copyWith(status: AddLocationStatus.failure));
        }
      }, (position) {
        // if (state.status == AddLocationStatus.failure) {
        emit(state.copyWith(
          status: AddLocationStatus.normal,
          latitude: position.latitude,
          longitude: position.longitude,
        ));
        // }
      });
    });
  }

  void onAddLocation() async {
    emit(state.copyWith(
      status: AddLocationStatus.editing,
      latitude: state.latitude,
      longitude: state.longitude,
      pointName: DateTime.now().toString(),
    ));
  }

  void onSaveLocation({
    required double latitude,
    required double longitude,
    required String pointName,
  }) async {
    emit(state.copyWith(status: AddLocationStatus.loading));
    final addLocationResult = await _addLocation(LocationArgument(
        latitude: latitude, longitude: longitude, pointName: pointName));
    addLocationResult.fold(
      (failure) {
        emit(state.copyWith(status: AddLocationStatus.failure));
      },
      (result) {
        emit(state.copyWith(status: AddLocationStatus.normal));
      },
    );
  }
}
