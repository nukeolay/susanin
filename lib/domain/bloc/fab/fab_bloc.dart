import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'fab_events.dart';
import 'fab_states.dart';

class FabBloc extends Bloc<FabEvent, FabState> {
  FabBloc() : super(FabStateInit());

  @override
  Stream<FabState> mapEventToState(FabEvent fabEvent) async* {
    if (fabEvent is FabEventPressed) {
      yield FabStateLoading();
    }
    if (fabEvent is FabEventLoading) {
      yield FabStateLoading();
    }
    if (fabEvent is FabEventLoaded) {
      yield FabStateNormal();
    }
    if (fabEvent is FabEventError) {
      yield FabStateError();
    }
    if (fabEvent is FabEventErrorStop) {
      yield FabStateErrorStop();
    }
  }
}
