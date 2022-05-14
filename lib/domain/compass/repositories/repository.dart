import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/compass/entities/compass.dart';

abstract class CompassRepository {
  Stream<Either<Failure, CompassEntity>> get compassStream;
  Future<void> close();
}
