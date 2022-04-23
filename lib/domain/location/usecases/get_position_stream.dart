import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location/entities/position.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class GetPositionStream
    extends UseCase<Stream<Either<Failure, PositionEntity>>> {
  final LocationServiceRepository _positionRepository;
  GetPositionStream(this._positionRepository);
  @override
  Stream<Either<Failure, PositionEntity>> call() {
    return _positionRepository.positionStream;
  }
}
