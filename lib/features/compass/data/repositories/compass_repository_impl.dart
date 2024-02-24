import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:susanin/features/compass/data/services/compass_service.dart';
import 'package:susanin/features/compass/domain/entities/compass.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';

class CompassRepositoryImpl implements CompassRepository {
  CompassRepositoryImpl(this._compassService);

  final CompassService _compassService;
  final _streamController = BehaviorSubject<CompassEntity>();
  StreamSubscription<CompassEntity>? _streamSubscription;

  @override
  ValueStream<CompassEntity> get compassStream {
    if (_streamSubscription == null) {
      final stream = _compassService.compassStream;
      _streamSubscription = stream.listen((event) {
        _streamController.add(event);
      }, onError: (error) {
        _streamController.addError(error);
      });
    }
    return _streamController.stream;
  }
}
