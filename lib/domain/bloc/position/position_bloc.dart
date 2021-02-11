import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:susanin/domain/bloc/position/position_events.dart';
import 'package:susanin/domain/bloc/position/position_states.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  Stream<Position> positionStream;

  PositionBloc(this.positionStream) : super(PositionStateLoading());

  @override
  Stream<PositionState> mapEventToState(PositionEvent positionEvent) async* {
    bool serviceEnabled;
    LocationPermission permission;
    if (positionEvent is PositionEventGetLocationService) {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        yield PositionStateErrorServiceDisabled();
      } else {
        permission = await Geolocator.checkPermission();//todo перенести все эти проверки в виджет, как в компассе, потому что в виджете по потоку строится и там постоянно можно проверяить наличие сервиса и доступа
        if (permission == LocationPermission.deniedForever) {
          yield PositionStateErrorPermissionDenied();
        } else if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
            yield PositionStateErrorPermissionDenied();
          }
        } else {
          yield PositionStateLoaded(positionStream);
        }
      }
    }
    else if (positionEvent is PositionEventError) {//todo ту ничего не проверено
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        yield PositionStateErrorServiceDisabled();
      } else {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.deniedForever) {
          yield PositionStateErrorPermissionDenied();
        } else if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
            yield PositionStateErrorPermissionDenied();
          }
        } else {
          yield PositionStateLoaded(positionStream);
        }
      }
    }
  }
}
