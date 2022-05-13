import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/compass/platform/compass_platform.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/repositories/repository.dart';

class CompassRepositoryImpl implements CompassRepository {
  final CompassPlatform compass;

  CompassRepositoryImpl(this.compass) {
    _init();
  }

  final StreamController<Either<Failure, CompassEntity>> _streamController =
      StreamController.broadcast();

  @override
  Stream<Either<Failure, CompassEntity>> get compassStream =>
      _streamController.stream;

  void _init() async {
    compass.compassStream.listen((event) {
      _streamController.add(Right(event));
    }).onError((error) {
      _streamController.add(Left(CompassFailure()));
    });

    // try {
    //   await for (final compassPlatform in compass.compassStream) {
    //     yield Right(compassPlatform); // ! TODO await for replace with listen
    //   }
    // } catch (error) {
    //   yield Left(CompassFailure());
    // }
  }
}
