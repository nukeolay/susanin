import 'package:get_it/get_it.dart';
import 'package:susanin/data/location/datasources/location_service_properties_datasource.dart';
import 'package:susanin/data/location/datasources/position_datasource.dart';
import 'package:susanin/data/location/repositories/repository_impl.dart';
import 'package:susanin/domain/location/repositories/repository.dart';
import 'package:susanin/domain/location/usecases/get_bearing_between.dart';
import 'package:susanin/domain/location/usecases/get_distance_between.dart';
import 'package:susanin/domain/location/usecases/get_location_service_properties.dart';
import 'package:susanin/domain/location/usecases/get_position_stream.dart';
import 'package:susanin/domain/location/usecases/request_permission.dart';
import 'package:susanin/presentation/bloc/main_pointer_cubit/main_pointer_cubit.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  serviceLocator.registerFactory(
    () => MainPointerCubit(
      getPositionStream: serviceLocator(),
      getDistanceBetween: serviceLocator(),
    ),
  );

  // ---UseCases---
  // Position
  serviceLocator.registerLazySingleton<GetPositionStream>(
    () => GetPositionStream(serviceLocator()),
  );
  // serviceLocator.registerLazySingleton<GetPosition>(
  //   () => GetPosition(serviceLocator()),
  // );
  serviceLocator.registerLazySingleton<GetDistanceBetween>(
    () => GetDistanceBetween(),
  );
  serviceLocator.registerLazySingleton<GetBearingBetween>(
    () => GetBearingBetween(),
  );
  serviceLocator.registerLazySingleton<RequestPermission>(
    () => RequestPermission(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetLocationServiceProperties>(
    () => GetLocationServiceProperties(serviceLocator()),
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
      positionDataSource: serviceLocator(),
      propertiesDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PositionDataSource>(
    () => PositionDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<LocationServicePropertiesDataSource>(
    () => LocationServicePropertiesDataSourceImpl(),
  );

  // // LevelsRepository
  // serviceLocator.registerLazySingleton<LevelsRepository>(
  //   () => LevelsRepositoryImpl(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<LevelsPrefsUtil>(
  //   () => LevelsPrefsUtil(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<LevelsPrefsService>(
  //   () => LevelsPrefsService(serviceLocator()),
  // );

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

  // // ---External---
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // serviceLocator
  //     .registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // // -- Repositories Init --
  // await serviceLocator<LevelsRepository>().load();
  // await serviceLocator<HintsRepository>().load();
  // await serviceLocator<TutorialRepository>().load();
}
