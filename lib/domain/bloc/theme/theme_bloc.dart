import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/theme/theme_events.dart';
import 'package:susanin/domain/bloc/theme/theme_states.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninData; //тут будем хранить локальную копию и получать ее только при загрузке программы
  ThemeMode themeMode;

  ThemeBloc(this.susaninRepository) : super(ThemeStateInit());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    if (themeEvent is ThemeEventGetData) {
      susaninData = await susaninRepository.getSusaninData();
      themeMode = susaninData.getIsDarkTheme ? ThemeMode.dark : ThemeMode.light;
      await Future.delayed(Duration(seconds: 1));
      if (susaninData.getIsFirstTime) {
        yield ThemeStateShowInstruction();
      } else {
        yield ThemeStateLoaded(themeMode: themeMode);
      }
    }
    if (themeEvent is ThemeEventPressed) {
      susaninData = await susaninRepository.getSusaninData();
      ThemeMode newThemeMode = !susaninData.getIsDarkTheme ? ThemeMode.dark : ThemeMode.light;
      susaninData.setIsDarkTheme(!susaninData.getIsDarkTheme);
      await susaninRepository.setSusaninData(susaninData: susaninData);
      yield ThemeStateLoaded(themeMode: newThemeMode);
    }
    if (themeEvent is ThemeEventInstructionShowed) {
      susaninData = await susaninRepository.getSusaninData();
      susaninData.setIsFirstTime(false);
      await susaninRepository.setSusaninData(susaninData: susaninData);
      themeMode = susaninData.getIsDarkTheme ? ThemeMode.dark : ThemeMode.light;
      yield ThemeStateLoaded(themeMode: themeMode);
    }
  }
}
