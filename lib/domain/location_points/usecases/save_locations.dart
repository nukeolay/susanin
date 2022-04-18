import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';

class SaveLocations
    extends UseCaseWithArguments<Future<void>, List<LocationPointEntity>> {
  final LocationPointsRepository _locationPointsRepository;
  SaveLocations(this._locationPointsRepository);
  @override
  Future<void> call(List<LocationPointEntity> argument) async {
    await _locationPointsRepository.saveLocations(argument);
  }
}
