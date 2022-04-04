import 'package:get_it/get_it.dart';
import 'package:susanin/data/position/geolocator/geolocator_util.dart';
import 'package:susanin/data/position/geolocator/services/geolocator_service.dart';
import 'package:susanin/data/position/repositories/repository_impl.dart';
import 'package:susanin/domain/position/repositories/repository.dart';
import 'package:susanin/domain/position/usecases/get_bearing_between.dart';
import 'package:susanin/domain/position/usecases/get_distance_between.dart';
import 'package:susanin/domain/position/usecases/get_position.dart';
import 'package:susanin/domain/position/usecases/get_position_stream.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  // serviceLocator.registerFactory(
  //   () => PersonListCubit(getAllPersons: serviceLocator()),
  // );
  // serviceLocator.registerFactory(
  //   () => PersonSearchBloc(searchPerson: serviceLocator()),
  // );

  // ---UseCases---
  // Position
  serviceLocator.registerLazySingleton<GetPosition>(
    () => GetPosition(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetPositionStream>(
    () => GetPositionStream(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetDistanceBetween>(
    () => GetDistanceBetween(),
  );
  serviceLocator.registerLazySingleton<GetBearingBetween>(
    () => GetBearingBetween(),
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

  // // ---Repository---
  // PositionRepository
  serviceLocator.registerLazySingleton<PositionRepository>(
    () => PositionRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GeolocatorUtil>(
    () => GeolocatorUtil(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GeolocatorService>(
    () => GeolocatorService(),
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
