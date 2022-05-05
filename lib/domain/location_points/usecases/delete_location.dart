import 'package:dartz/dartz.dart';
import 'package:susanin/core/errors/failure.dart';
import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/settings/entities/settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';

class DeleteLocation
    extends UseCaseWithArguments<Future<Either<Failure, bool>>, String> {
  final LocationPointsRepository _locationPointsRepository;
  final SetActiveLocation _setActiveLocation;
  final GetSettings _getSettings;
  DeleteLocation({
    required LocationPointsRepository locationPointsRepository,
    required SetActiveLocation setActiveLocation,
    required GetSettings getSettings,
  })  : _locationPointsRepository = locationPointsRepository,
        _setActiveLocation = setActiveLocation,
        _getSettings = getSettings;

  @override
  Future<Either<Failure, bool>> call(String argument) async {
    final locationsOrFailure = _locationPointsRepository.locationsOrFailure;
    final activeLocationIdOrFailure = _getSettings();

    if (locationsOrFailure.isRight()) {
      try {
        final locations = locationsOrFailure.getOrElse(() => []);
        final activeLocationId = activeLocationIdOrFailure.isRight()
            ? activeLocationIdOrFailure
                .getOrElse(() => const SettingsEntity(
                    isDarkTheme: false,
                    isFirstTime: false,
                    activeLocationId: ''))
                .activeLocationId
            : '';
        // deleting location with id == argument
        final index = locations
            .indexWhere((savedLocation) => savedLocation.id == argument);
        locations.removeAt(index);
        final String newActiveLocationId;
        // checking if deleted locatoin was active
        if (activeLocationId == argument) {
          if (locations.isEmpty) {
            newActiveLocationId = '';
          } else {
            final newIndex = index == 0 ? 0 : index - 1;
            newActiveLocationId = locations[newIndex].id;
          }
          await _setActiveLocation(
              newActiveLocationId); // ! TODO сделать nullable и не передавать ''
        }
        // updating locations list
        await _locationPointsRepository.save(locations);
        return const Right(true);
      } catch (error) {
        return Left(LocationPointRemoveFailure());
      }
    } else {
      return Left(LocationPointRemoveFailure());
    }
  }
}
