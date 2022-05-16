import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class LocationServiceRepository {
  Stream<Either<Failure, PositionEntity>> get positionStream;
  Future<bool> requestPermission();
  Future<void> close();
}
