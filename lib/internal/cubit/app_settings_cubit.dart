import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/settings/domain/entities/settings.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const AppSettingsInitialState());

  final SettingsRepository _settingsRepository;
  StreamSubscription<SettingsEntity>? _streamSubscription;

  void init() {
    _streamSubscription ??= _settingsRepository.settingsStream.listen(
      (event) {
        emit(
          AppSettingsLoadedState(
            isFirstTime: event.isFirstTime,
            themeMode: event.themeMode,
          ),
        );
      },
    );
  }

  Future<void> toggleTheme() async {
    final currentState = state;
    if (currentState is! AppSettingsLoadedState) {
      return;
    }
    await _settingsRepository.setTheme(
      currentState.isDarkTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    super.close();
  }
}
