import 'package:get_it/get_it.dart';

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
  // Hints
  // serviceLocator.registerLazySingleton<ResetHints>(
  //   () => ResetHints(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<SingleFlipsDecrement>(
  //   () => SingleFlipsDecrement(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<SingleFlipsIncrement>(
  //   () => SingleFlipsIncrement(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<SolutionsNumberDecrement>(
  //   () => SolutionsNumberDecrement(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<SolutionsNumberIncrement>(
  //   () => SolutionsNumberIncrement(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<UpdateHints>(
  //   () => UpdateHints(serviceLocator()),
  // );

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
  // // HintsRepository
  // serviceLocator.registerLazySingleton<HintsRepository>(
  //   () => HintsRepositoryImpl(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<HintsPrefsUtil>(
  //   () => HintsPrefsUtil(serviceLocator()),
  // );
  // serviceLocator.registerLazySingleton<HintsPrefsService>(
  //   () => HintsPrefsService(serviceLocator()),
  // );

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
