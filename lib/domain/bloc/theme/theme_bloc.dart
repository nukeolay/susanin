import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/theme/theme_events.dart';
import 'package:susanin/domain/bloc/theme/theme_states.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/theme/config.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  SusaninData susaninData; //тут будем хранить локальную копию и получать ее только при загрузке программы

  ThemeBloc(this.susaninRepository) : super(ThemeStateInit());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    if (themeEvent is ThemeEventPressed) {
      yield ThemeStateToggled();
      susaninData = await susaninRepository.getSusaninData();
      currentTheme.toggleTheme(); // переключили тему
      susaninData.setIsDarkTheme(!susaninData.getIsDarkTheme); // переключили тему
      await susaninRepository.setSusaninData(susaninData: susaninData);
    }
  }
}
