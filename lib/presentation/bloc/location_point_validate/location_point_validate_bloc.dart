import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_state.dart';

class LocationPointValidateBloc
    extends Bloc<LocationPointValidateEvent, LocationPointValidateState> {
  final GetLocations _getLocations;

  LocationPointValidateBloc({required GetLocations getLocations})
      : _getLocations = getLocations,
        super(const LocationPointValidateState(
          isNameValid: true,
          isLatutideValid: true,
          isLongitudeValid: true,
        )) {
    on<NameChanged>(_onNameChanged);
    on<LatitudeChanged>(_onLatitudeChanged);
    on<LongitudeChanged>(_onLongitudeChanged);
    on<FlushValidator>(_onFlushValidator);
  }

  void _onNameChanged(
      NameChanged event, Emitter<LocationPointValidateState> emit) {
    final locations = _getLocations().getOrElse(() => []);
    final name = event.name;
    final index =
        locations.indexWhere((location) => location.pointName == name);
    emit(state.copyWith(
      isNameValid: index == -1 && name != '' ? true : false,
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

  void _onFlushValidator(
      FlushValidator event, Emitter<LocationPointValidateState> emit) {
    emit(state.copyWith(
      isNameValid: true,
      isLatutideValid: true,
      isLongitudeValid: true,
    ));
  }
}

class EditLocationPointValidateBloc extends LocationPointValidateBloc {
  EditLocationPointValidateBloc({required GetLocations getLocations})
      : super(getLocations: getLocations);

  @override
  void _onNameChanged(
      NameChanged event, Emitter<LocationPointValidateState> emit) {
    final locations = _getLocations().getOrElse(() => []);
    final index =
        locations.indexWhere((location) => location.pointName == event.name);
    if (event.oldName != null) {
      emit(state.copyWith(
        isNameValid:
            index == -1 || event.name == event.oldName && event.name != ''
                ? true
                : false,
      ));
    } else {
      emit(state.copyWith(
        isNameValid: index == -1 && event.name != '' ? true : false,
      ));
    }
  }
}
