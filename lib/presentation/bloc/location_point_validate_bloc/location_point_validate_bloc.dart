import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_state.dart';

class LocationPointValidateBloc
    extends Bloc<LocationPointValidateEvent, LocationPointValidateState> {
  LocationPointValidateBloc()
      : super(const LocationPointValidateState(
          isNameValid: true,
          isLatutideValid: true,
          isLongitudeValid: true,
        )) {
    on<NameChanged>(_onNameChanged);
    on<LatitudeChanged>(_onLatitudeChanged);
    on<LongitudeChanged>(_onLongitudeChanged);
  }

  void _onNameChanged(
      NameChanged event, Emitter<LocationPointValidateState> emit) {
    final name = event.name;
    emit(state.copyWith(
      isNameValid: name != '' ? true : false,
    ));
  }

  void _onLatitudeChanged(
      LatitudeChanged event, Emitter<LocationPointValidateState> emit) {
    final latitude = double.tryParse(event.latitude);
    if (latitude != null && latitude.abs() <= 90) {
      emit(state.copyWith(
        isLatutideValid: true,
      ));
    } else {
      emit(state.copyWith(
        isLatutideValid: false,
      ));
    }
  }

  void _onLongitudeChanged(
      LongitudeChanged event, Emitter<LocationPointValidateState> emit) {
    final longitude = double.tryParse(event.longitude);
    if (longitude != null && longitude.abs() <= 180) {
      emit(state.copyWith(
        isLongitudeValid: true,
      ));
    } else {
      emit(state.copyWith(
        isLongitudeValid: false,
      ));
    }
  }
}
