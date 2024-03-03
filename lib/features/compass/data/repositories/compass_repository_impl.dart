import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart' as compass;
import 'package:rxdart/rxdart.dart';
import 'package:susanin/core/errors/exceptions.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';

class CompassRepositoryImpl implements CompassRepository {
  CompassRepositoryImpl();

  final _streamController = BehaviorSubject<CompassEntity>();
  Stream<compass.CompassEvent>? _compassStream;
  StreamSubscription<compass.CompassEvent>? _streamSubscription;

  @override
  ValueStream<CompassEntity> get compassStream {
    _compassStream ??= compass.FlutterCompass.events;
    if (_compassStream == null) {
      // This device has no compass
      throw CompassException();
    }
    _streamSubscription ??= _compassStream?.listen(
      (event) {
        final compasEntity = CompassEntity(
          accuracy: event.accuracy!,
          north: event.heading!,
        );
        _streamController.add(compasEntity);
      },
      onError: (error) {
        _streamController.addError(error);
      },
    )?..onError((_) {
        throw CompassException();
      });
    return _streamController.stream;
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _streamController.close();
  }
}
