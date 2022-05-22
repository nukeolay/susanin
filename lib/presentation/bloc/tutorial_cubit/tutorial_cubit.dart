import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/settings/usecases/get_settings.dart';
import 'package:susanin/domain/settings/usecases/toggle_is_first_time.dart';
import 'package:susanin/presentation/bloc/tutorial_cubit/turorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> {
  final GetSettings _getSettings;
  final ToggleIsFirstTime _toggleIsFirstTime;

  TutorialCubit({
    required GetSettings getSettings,
    required ToggleIsFirstTime toggleIsFirstTime,
  })  : _getSettings = getSettings,
        _toggleIsFirstTime = toggleIsFirstTime,
        super(const TutorialState(
          tutorialStatus: TutorialStatus.loading,
          isFirstTime: false,
        )) {
    _init();
  }

  void _init() {
    _getSettings().fold(
      (failure) => emit(state.copyWith(
        tutorialStatus: TutorialStatus.loaded,
        isFirstTime: true,
      )),
      (settings) => emit(state.copyWith(
        tutorialStatus: TutorialStatus.loaded,
        isFirstTime: settings.isFirstTime,
      )),
    );
  }

  void start() {
    _toggleIsFirstTime();
  }
}
