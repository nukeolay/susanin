import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class DeleteLocation
    extends UseCaseWithArguments<Future<Either<Failure, bool>>, String> {
  final LocationPointsRepository _locationPointsRepository;
  DeleteLocation(this._locationPointsRepository);
  @override
  Future<Either<Failure, bool>> call(String argument) async {
    final locationsOrFailure = _locationPointsRepository.locationsOrFailure;
    if (locationsOrFailure.isRight()) {
      final locations = locationsOrFailure.getOrElse(() => []);
      locations
          .removeWhere((savedLocation) => savedLocation.id == argument);
      await _locationPointsRepository.saveLocations(locations);
      return const Right(true);
    } else {
      return Left(LocationPointRemoveFailure());
    }
  }
}
