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
    final locationsOrFailure =
        await _locationPointsRepository.locationsStream.last;
    try {
      locationsOrFailure.fold((failure) {
        return Left(failure);
      }, (locations) async {
        locations.removeWhere(
            (savedLocation) => savedLocation.pointName == argument);
        await _locationPointsRepository.saveLocations(locations);
        return const Right(true);
      });
    } catch (error) {
      return Left(LocationPointRemoveFailure());
    }
    return const Right(true);
  }
}
