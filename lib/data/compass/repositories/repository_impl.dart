import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/data/compass/platform/compass_platform.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/repositories/repository.dart';

class CompassRepositoryImpl implements CompassRepository {
  final CompassPlatform compass;

  CompassRepositoryImpl(this.compass);

  @override
  Stream<Either<Failure, CompassEntity>> get compassStream async* {
    try {
      await for (final compassPlatform in compass.compassStream) {
        yield Right(compassPlatform);
      }
    } catch (error) {
      yield Left(CompassFailure());
    }
  }
}
