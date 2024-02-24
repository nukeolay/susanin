import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'validator_state.dart';
part 'validator_event.dart';

class LocationValidatorBloc
    extends Bloc<LocationValidatorEvent, LocationValidatorState> {
  LocationValidatorBloc()
      : super(const LocationValidatorState(
          isNameValid: true,
          isLatutideValid: true,
          isLongitudeValid: true,
        )) {
    on<NameChanged>(_onNameChanged);
    on<LatitudeChanged>(_onLatitudeChanged);
    on<LongitudeChanged>(_onLongitudeChanged);
  }

  void _onNameChanged(NameChanged event, Emitter<LocationValidatorState> emit) {
    final name = event.name;
    emit(state.copyWith(
      isNameValid: name != '' ? true : false,
    ));
  }

  void _onLatitudeChanged(
      LatitudeChanged event, Emitter<LocationValidatorState> emit) {
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
      LongitudeChanged event, Emitter<LocationValidatorState> emit) {
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
