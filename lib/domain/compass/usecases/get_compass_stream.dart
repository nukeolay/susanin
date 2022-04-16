import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/compass/repositories/repository.dart';

class GetCompassStream extends UseCase<Stream<Either<Failure, CompassEntity>>> {
  final CompassRepository _compassRepository;
  GetCompassStream(this._compassRepository);
  @override
  Stream<Either<Failure, CompassEntity>> call() {
    return _compassRepository.compassStream;
  }
}
