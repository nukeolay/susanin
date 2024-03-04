import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(AppSettingsState.initial) {
    _init();
  }

  final SettingsRepository _settingsRepository;
  StreamSubscription<SettingsEntity>? _streamSubscription;

  void _init() {
    final stream = _settingsRepository.settingsStream;
    final lastValue = stream.valueOrNull;
    emit(state.copyWith(
      isDarkTheme: lastValue?.themeMode.isDark,
      isFirstTime: lastValue?.isFirstTime,
      isLoading: false,
    ));
    _streamSubscription = stream.listen((event) {
      emit(state.copyWith(
        isDarkTheme: event.themeMode.isDark,
        isFirstTime: event.isFirstTime,
      ));
    });
  }

  Future<void> toggleTheme() {
    return _settingsRepository.setTheme(
      state.isDarkTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    super.close();
  }
}
