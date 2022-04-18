import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:susanin/data/compass/platform/compass_platform.dart';
import 'package:susanin/data/compass/repositories/repository_impl.dart';
import 'package:susanin/data/location/platform/location_service_permission_platform.dart';
import 'package:susanin/data/location/platform/position_platform.dart';
import 'package:susanin/data/location/repositories/repository_impl.dart';
import 'package:susanin/data/location_points/datasources/location_points_data_source.dart';
import 'package:susanin/data/location_points/repositories/repository_impl.dart';
import 'package:susanin/domain/compass/repositories/repository.dart';
import 'package:susanin/domain/compass/usecases/get_compass_stream.dart';
import 'package:susanin/domain/location/repositories/repository.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/domain/location_points/repositories/repository.dart';
import 'package:susanin/domain/location_points/usecases/load_locations.dart';
import 'package:susanin/domain/location_points/usecases/save_locations.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/location_points_cubit.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  serviceLocator.registerFactory(
    () => MainPointerCubit(
      getPositionStream: serviceLocator(),
      getDistanceBetween: serviceLocator(),
      getCompassStream: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LocationPointsCubit(
      loadLocations: serviceLocator(),
      saveLocations: serviceLocator(),
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
  serviceLocator.registerLazySingleton<LoadLocations>(
    () => LoadLocations(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SaveLocations>(
    () => SaveLocations(serviceLocator()),
  );

  // // Levels
  // serviceLocator.registerLazySingleton<ResetLevels>(
  //   () => ResetLevels(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<GetChapters>(
  //   () => GetChapters(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<GetLevels>(
  //   () => GetLevels(serviceLocator()),
  // );

  // serviceLocator.registerLazySingleton<CompleteLevel>(
  //   () => CompleteLevel(serviceLocator()),
  // );

  // // Tutorial
  // serviceLocator.registerLazySingleton<GetTutorial>(
  //   () => GetTutorial(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<UpdateTutorial>(
  //   () => UpdateTutorial(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<ResetTutorial>(
  //   () => ResetTutorial(serviceLocator()),
  // );

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
  serviceLocator.registerLazySingleton<LocationPointDataSource>(
    () => LocationPointDataSourceImpl(serviceLocator()),
  );

  // // TutorialRepository
  // serviceLocator.registerLazySingleton<TutorialRepository>(
  //   () => TutorialRepositoryImpl(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<TutorialPrefsUtil>(
  //   () => TutorialPrefsUtil(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<TutorialPrefsService>(
  //   () => TutorialPrefsService(serviceLocator()),
  // );

  // // ---Core---
  // // empty

  // ---External---
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  serviceLocator
      .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // -- Repositories Init --
  await serviceLocator<LocationPointsRepository>().locations;
}
