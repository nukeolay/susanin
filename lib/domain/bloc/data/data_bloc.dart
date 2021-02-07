import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/domain/bloc/location/location_events.dart';
import 'package:susanin/domain/model/location_point.dart';
import 'package:susanin/domain/model/susanin_data.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';
import 'package:susanin/internal/dependencies/repository_module.dart';
import 'package:susanin/presentation/theme/config.dart';

import 'data_events.dart';
import 'data_states.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  SusaninRepository susaninRepository = RepositoryModule.susaninRepository();
  bool firstTime = true;

  DataBloc(this.susaninRepository) : super(DataStateDataLoading());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataEventGetData) {
      // когда приложение стартует, сначала переходим в состояние загрузки данных, потом переходим в состояние что данные загружены
      try {
        SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
        currentTheme.setThemeMode(_susaninData.getIsDarkTheme); // переключили тему
        yield DataStateDataLoaded();
      } catch (e) {
        yield DataStateDataLoaded();
      }
    } else if (event is DataEventPressedToggleTheme) {
      // если нажали кнопку переключить тему, то сначала изменится значение переменной, потом эти данные запишутся в память телефона, и только потом перейдем в состояние того, что тема переключилась
      SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
      currentTheme.toggleTheme(); // переключили тему
      _susaninData.setIsDarkTheme(!_susaninData.getIsDarkTheme); // переключили тему
      susaninRepository.setSusaninData(
          susaninData:
              _susaninData); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield DataStateDataLoaded();
    }
  }
}
