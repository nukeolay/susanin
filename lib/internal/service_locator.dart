import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/data/compass/platform/compass_platform.dart';
import 'package:susanin/data/compass/repositories/repository_impl.dart';
import 'package:susanin/data/location/platform/location_service_permission_platform.dart';
import 'package:susanin/data/location/platform/position_platform.dart';
import 'package:susanin/data/location/repositories/repository_impl.dart';
import 'package:susanin/data/location_points/datasources/location_points_data_source.dart';
import 'package:susanin/data/location_points/repositories/repository_impl.dart';
import 'package:susanin/data/settings/datasources/settings_data_source.dart';
import 'package:susanin/data/settings/repositories/repository_impl.dart';
import 'package:susanin/data/wakelock/platform/wakelock_platform.dart';
import 'package:susanin/data/wakelock/repositories/repository_impl.dart';
import 'package:susanin/domain/compass/repositories/repository.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/repositories/repository.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/settings/usecases/get_active_location.dart';
import 'package:susanin/domain/settings/usecases/get_active_location_stream.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/domain/location_points/usecases/add_location.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings_stream.dart';
import 'package:susanin/domain/settings/usecases/get_theme_mode.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';
import 'package:susanin/domain/settings/usecases/toggle_is_first_time.dart';
import 'package:susanin/domain/settings/usecases/toggle_theme.dart';
import 'package:susanin/domain/wakelock/repositories/repository.dart';
import 'package:susanin/domain/wakelock/usecases/get_wakelock_enabled_status.dart';
import 'package:susanin/domain/wakelock/usecases/toggle_wakelock.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/bloc/tutorial_cubit/tutorial_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
// ---External---
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

// ---Repository---
  // PositionRepository
  serviceLocator.registerLazySingleton<PositionPlatform>(
    () => PositionPlatformStreamImpl(),
  );
  serviceLocator.registerLazySingleton<LocationServicePermissionPlatform>(
    () => LocationServicePropertiesPlatformImpl(),
  );
  serviceLocator.registerLazySingleton<LocationServiceRepository>(
    () => LocationServiceRepositoryImpl(
      position: serviceLocator<PositionPlatform>(),
      properties: serviceLocator<LocationServicePermissionPlatform>(),
    ),
  );

  // CompassRepository
  serviceLocator.registerSingleton<CompassPlatform>(
    CompassPlatformImpl(),
  );
  serviceLocator.registerSingleton<CompassRepository>(
    CompassRepositoryImpl(serviceLocator<CompassPlatform>()),
  );

  // LocationPointsRepository
  serviceLocator.registerLazySingleton<LocationsDataSource>(
    () => LocationsDataSourceImpl(serviceLocator<SharedPreferences>()),
  );
  serviceLocator.registerLazySingleton<LocationPointsRepository>(
    () => LocationPointsRepositoryImpl(serviceLocator<LocationsDataSource>()),
  );

  // SettingsRepository
  serviceLocator.registerLazySingleton<SettingsDataSource>(
    () => SettingsDataSourceImpl(serviceLocator<SharedPreferences>()),
  );
  serviceLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(serviceLocator<SettingsDataSource>()),
  );

  // WakelockRepository
  serviceLocator.registerLazySingleton<WakelockPlatform>(
    () => WakelockPlatformImpl(),
  );
  serviceLocator.registerLazySingleton<WakelockRepository>(
    () => WakelockRepositoryImpl(serviceLocator<WakelockPlatform>()),
  );

// ---UseCases---
  // Settings
  serviceLocator.registerLazySingleton<GetSettingsStream>(
    () => GetSettingsStream(serviceLocator<SettingsRepository>()),
  );
  serviceLocator.registerLazySingleton<GetSettings>(
    () => GetSettings(serviceLocator<SettingsRepository>()),
  );
  serviceLocator.registerLazySingleton<SetActiveLocation>(
    () => SetActiveLocation(serviceLocator<SettingsRepository>()),
  );
  serviceLocator.registerLazySingleton<ToggleTheme>(
    () => ToggleTheme(serviceLocator<SettingsRepository>()),
  );
  serviceLocator.registerLazySingleton<ToggleIsFirstTime>(
    () => ToggleIsFirstTime(serviceLocator<SettingsRepository>()),
  );
  serviceLocator.registerLazySingleton<GetThemeMode>(
    () => GetThemeMode(serviceLocator<SettingsRepository>()),
  );

  // Position
  serviceLocator.registerLazySingleton<GetPositionStream>(
    () => GetPositionStream(serviceLocator<LocationServiceRepository>()),
  );
  serviceLocator.registerLazySingleton<GetDistanceBetween>(
    () => GetDistanceBetween(),
  );
  serviceLocator.registerLazySingleton<GetBearingBetween>(
    () => GetBearingBetween(),
  );
  serviceLocator.registerLazySingleton<RequestPermission>(
    () => RequestPermission(serviceLocator<LocationServiceRepository>()),
  );

  // Compass
  serviceLocator.registerSingleton<GetCompassStream>(
    GetCompassStream(serviceLocator<CompassRepository>()),
  );

  // LocationPoints
  serviceLocator.registerLazySingleton<GetLocationsStream>(
    () => GetLocationsStream(serviceLocator<LocationPointsRepository>()),
  );
  serviceLocator.registerLazySingleton<GetLocations>(
    () => GetLocations(serviceLocator<LocationPointsRepository>()),
  );
  serviceLocator.registerLazySingleton<AddLocation>(
    () => AddLocation(
      locationPointsRepository: serviceLocator<LocationPointsRepository>(),
      setActiveLocation: serviceLocator<SetActiveLocation>(),
    ),
  );
  serviceLocator.registerLazySingleton<UpdateLocation>(
    () => UpdateLocation(serviceLocator<LocationPointsRepository>()),
  );
  serviceLocator.registerLazySingleton<DeleteLocation>(
    () => DeleteLocation(
      locationPointsRepository: serviceLocator<LocationPointsRepository>(),
      setActiveLocation: serviceLocator<SetActiveLocation>(),
      getSettings: serviceLocator<GetSettings>(),
    ),
  );
  serviceLocator.registerLazySingleton<GetActiveLocation>(
    () => GetActiveLocation(
      locationPointsRepository: serviceLocator<LocationPointsRepository>(),
      settingsRepository: serviceLocator<SettingsRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton<GetActiveLocationStream>(
    () => GetActiveLocationStream(
      locationPointsRepository: serviceLocator<LocationPointsRepository>(),
      settingsRepository: serviceLocator<SettingsRepository>(),
    ),
  );

  // Wakelock
  serviceLocator.registerLazySingleton<GetWakelockEnabledStatus>(
    () => GetWakelockEnabledStatus(serviceLocator<WakelockRepository>()),
  );
  serviceLocator.registerLazySingleton<ToggleWakelock>(
    () => ToggleWakelock(serviceLocator<WakelockRepository>()),
  );

// BLoC / Cubit
  serviceLocator.registerFactory(
    () => MainPointerCubit(
      getPositionStream: serviceLocator<GetPositionStream>(),
      getActiveLocationStream: serviceLocator<GetActiveLocationStream>(),
      getActiveLocation: serviceLocator<GetActiveLocation>(),
      getDistanceBetween: serviceLocator<GetDistanceBetween>(),
      getCompassStream: serviceLocator<GetCompassStream>(),
      getBearingBetween: serviceLocator<GetBearingBetween>(),
    ),
  );
  serviceLocator.registerFactory(
    () => DetailedInfoCubit(
      getPositionStream: serviceLocator<GetPositionStream>(),
      getDistanceBetween: serviceLocator<GetDistanceBetween>(),
      getCompassStream: serviceLocator<GetCompassStream>(),
      getBearingBetween: serviceLocator<GetBearingBetween>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CompassCubit(
      getCompassStream: serviceLocator<GetCompassStream>(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationsListCubit(
      getSettingsStream: serviceLocator<GetSettingsStream>(),
      getSettings: serviceLocator<GetSettings>(),
      getLocationsStream: serviceLocator<GetLocationsStream>(),
      getLocations: serviceLocator<GetLocations>(),
      updateLocation: serviceLocator<UpdateLocation>(),
      deleteLocation: serviceLocator<DeleteLocation>(),
      setActiveLocation: serviceLocator<SetActiveLocation>(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationPointValidateBloc(),
  );
  serviceLocator.registerFactory(
    () => AddLocationCubit(
      addLocation: serviceLocator<AddLocation>(),
      getPositionStream: serviceLocator<GetPositionStream>(),
    ),
  );
  serviceLocator.registerFactory(
    () => SettingsCubit(
      getCompassStream: serviceLocator<GetCompassStream>(),
      getPositionStream: serviceLocator<GetPositionStream>(),
      requestPermission: serviceLocator<RequestPermission>(),
      getWakelockEnabledStatus: serviceLocator<GetWakelockEnabledStatus>(),
      toggleWakelock: serviceLocator<ToggleWakelock>(),
      getThemeMode: serviceLocator<GetThemeMode>(),
      toggleTheme: serviceLocator<ToggleTheme>(),
    ),
  );
  serviceLocator.registerFactory(
    () => TutorialCubit(
      getSettings: serviceLocator<GetSettings>(),
      toggleIsFirstTime: serviceLocator<ToggleIsFirstTime>(),
    ),
  );
}
