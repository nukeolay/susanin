import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/features/compass/data/repositories/compass_repository_impl.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/data/repositories/location_repository_impl.dart';
import 'package:susanin/features/location/data/services/location_service.dart';
import 'package:susanin/features/location/data/services/permission_service.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/data/repositories/places_repository_impl.dart';
import 'package:susanin/features/places/data/services/places_service.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:susanin/features/settings/data/services/settings_service.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/wakelock/data/repositories/wakelock_repository_impl.dart';
import 'package:susanin/features/wakelock/data/services/wakelock_service.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

class RepositoryInitializer {
  RepositoryInitializer();

  late final LocationRepository _locationRepository;
  late final CompassRepository _compassRepository;
  late final PlacesRepository _placesRepository;
  late final SettingsRepository _settingsRepository;
  late final WakelockRepository _wakelockRepository;

  LocationRepository get locationRepository => _locationRepository;
  CompassRepository get compassRepository => _compassRepository;
  PlacesRepository get placesRepository => _placesRepository;
  SettingsRepository get settingsRepository => _settingsRepository;
  WakelockRepository get wakelockRepository => _wakelockRepository;

  void dispose() async {
    await _compassRepository.close();
  }

  Future<void> init() async {
    // External
    final sharedPreferences = await SharedPreferences.getInstance();

    // PositionRepository
    const locationService = LocationServiceImpl();
    const permissionService = PermissionServiceImpl();
    _locationRepository = LocationRepositoryImpl(
      locationService: locationService,
      permissionService: permissionService,
    );

    // CompassRepository
    _compassRepository = CompassRepositoryImpl();

    // LocationPointsRepository
    final placesService = PlacesServiceImpl(sharedPreferences);
    _placesRepository = PlacesRepositoryImpl(placesService);

    // SettingsRepository
    final settingsService = SettingsServiceImpl(sharedPreferences);
    _settingsRepository = SettingsRepositoryImpl(settingsService);

    // WakelockRepository
    const wakelockService = WakelockServiceImpl();
    _wakelockRepository = const WakelockRepositoryImpl(wakelockService);
  }
}
