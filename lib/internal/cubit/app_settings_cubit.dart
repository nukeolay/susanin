import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/settings/domain/entities/settings.dart';
import 'package:susanin/features/settings/domain/use_cases/get_settings_stream.dart';
import 'package:susanin/features/settings/domain/use_cases/toggle_theme.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required GetSettingsStream getSettingsStream,
    required ToggleTheme toggleTheme,
  })  : _getSettingsStream = getSettingsStream,
        _toggleTheme = toggleTheme,
        super(AppSettingsState.initial) {
    _init();
  }

  final GetSettingsStream _getSettingsStream;
  final ToggleTheme _toggleTheme;

  StreamSubscription<SettingsEntity>? _streamSubscription;

  void _init() {
    final stream = _getSettingsStream(const NoParams());
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

  void toggleTheme() => _toggleTheme(const NoParams());

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    super.close();
  }
}
