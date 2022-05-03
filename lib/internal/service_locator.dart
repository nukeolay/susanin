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
import 'package:susanin/domain/compass/repositories/repository.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/repositories/repository.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/location_points/usecases/delete_location.dart';
import 'package:susanin/domain/location_points/usecases/get_locations.dart';
import 'package:susanin/domain/location_points/usecases/get_locations_stream.dart';
import 'package:susanin/domain/location_points/usecases/update_location.dart';
import 'package:susanin/domain/location_points/usecases/add_location.dart';
import 'package:susanin/domain/settings/repositories/repository.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/get_settings_stream.dart';
import 'package:susanin/domain/settings/usecases/set_active_location.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/compass_cubit/compass_cubit.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // ---External---
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // BLoC / Cubit
  serviceLocator.registerFactory(
    () => MainPointerCubit(
      getPositionStream: serviceLocator(),
      getDistanceBetween: serviceLocator(),
      getCompassStream: serviceLocator(),
      getBearingBetween: serviceLocator(),
      getLocationsStream: serviceLocator(),
      getSettingsStream: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => CompassCubit(
      getCompassStream: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationsListCubit(
      getSettings: serviceLocator(),
      getSettingsStream: serviceLocator(),
      getLocationsStream: serviceLocator(),
      updateLocation: serviceLocator(),
      deleteLocation: serviceLocator(),
      setActiveLocation: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationPointValidateBloc(),
  );
  serviceLocator.registerFactory(
    () => AddLocationCubit(
      addLocation: serviceLocator(),
      getPositionStream: serviceLocator(),
      setActiveLocation: serviceLocator(),
    ),
  );

  // ---UseCases---
  // Position
  serviceLocator.registerLazySingleton<GetPositionStream>(
    () => GetPositionStream(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetDistanceBetween>(
    () => GetDistanceBetween(),
  );
  serviceLocator.registerLazySingleton<GetBearingBetween>(
    () => GetBearingBetween(),
  );
  serviceLocator.registerLazySingleton<RequestPermission>(
    () => RequestPermission(serviceLocator()),
  );

  // Compass
  serviceLocator.registerLazySingleton<GetCompassStream>(
    () => GetCompassStream(serviceLocator()),
  );

  // LocationPoints
  serviceLocator.registerLazySingleton<GetLocationsStream>(
    () => GetLocationsStream(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetLocations>(
    () => GetLocations(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AddLocation>(
    () => AddLocation(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateLocation>(
    () => UpdateLocation(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DeleteLocation>(
    () => DeleteLocation(serviceLocator()),
  );

  // Settings
  serviceLocator.registerLazySingleton<GetSettingsStream>(
    () => GetSettingsStream(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetSettings>(
    () => GetSettings(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SetActiveLocation>(
    () => SetActiveLocation(serviceLocator()),
  );

  // ---Repository---
  // PositionRepository
  serviceLocator.registerLazySingleton<LocationServiceRepository>(
    () => LocationServiceRepositoryImpl(
      position: serviceLocator(),
      properties: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PositionPlatform>(
    () => PositionPlatformImpl(),
  );
  serviceLocator.registerLazySingleton<LocationServicePermissionPlatform>(
    () => LocationServicePropertiesPlatformImpl(),
  );

  // CompassRepository
  serviceLocator.registerLazySingleton<CompassRepository>(
    () => CompassRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<CompassPlatform>(
    () => CompassPlatformImpl(),
  );

  // LocationPointsRepository
  serviceLocator.registerLazySingleton<LocationPointsRepository>(
    () => LocationPointsRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LocationsDataSource>(
    () => LocationsDataSourceImpl(serviceLocator()),
  );

  // SettingsRepository
  serviceLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SettingsDataSource>(
    () => SettingsDataSourceImpl(serviceLocator()),
  );

  // // ---Core---
  // // empty
}
