import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_compass/flutter_compass.dart';

import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';

class CompassRepositoryImpl implements CompassRepository {
  CompassRepositoryImpl();

  final _streamController = BehaviorSubject<CompassEntity>();
  Stream<CompassEvent>? _compassStream;
  StreamSubscription<CompassEvent>? _streamSubscription;

  @override
  ValueStream<CompassEntity> get compassStream {
    if (_streamSubscription != null) {
      return _streamController.stream;
    }
    _compassStream ??= FlutterCompass.events;
    if (_compassStream == null) {
      // This device has no compass
      _streamController.add(const CompassEntity.failure());
      return _streamController.stream;
    }
    _streamController.add(const CompassEntity.loading());
    _streamSubscription ??= _compassStream?.listen(
      (event) {
        final compasEntity = CompassEntity.value(
          accuracy: event.accuracy,
          north: event.heading,
        );
        _streamController.add(compasEntity);
      },
      onError: (error) {
        _streamController.add(const CompassEntity.failure());
      },
    )?..onError((_) {
        _streamController.add(const CompassEntity.failure());
      });
    return _streamController.stream;
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    await _streamController.close();
  }
}
