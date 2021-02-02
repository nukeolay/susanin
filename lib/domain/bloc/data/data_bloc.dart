import 'package:flutter_bloc/flutter_bloc.dart';
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
  DataBloc(this.susaninRepository) : super(DataStateStart());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataAppStartEvent) {
      // когда приложение стартует, сначала передем в состояние загрузки данных, потом переходим в состояние что данные загружены
      print("here1"); //todo удалить
      firstTime = false;
      yield DataStateDataLoading();
      print("here2"); //todo удалить
      try {
        print("here3"); //todo удалить
        SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
        if (_susaninData.getLocationList.length == 0) {
          print("here empty list"); //todo удалить
          yield DataStateEmptyLocationList(); // если список локаций пустой, то состояние AppStateEmptyLocationList и написать инструкцию вместо виджета со списком
        } else {
          print("here loaded list"); //todo удалить
          yield DataStateLocationListLoaded(
              _susaninData); // если список локаций не пустой, то состояние AppStateLocationListLoaded и вывести список локаций
        }
      } catch (e) {
        yield DataStateFirstTimeStarted();
      }
    }
    else if (event is DataEventPressedToggleTheme) {
      // если нажали кнопку переключить тему, то сначала изменится значение переменной, потом эти данные запишутся в память телефона, и только потом перейдем в состояние того, что тема переключилась
      SusaninData _susaninData = await susaninRepository.getSusaninData(); //получили синглтон репозитория
      currentTheme.toggleTheme(); // переключили тему
      _susaninData.setIsDarkTheme(currentTheme.getIsDarkTheme); // переключили тему
      susaninRepository.setSusaninData(
          susaninData:
              _susaninData); // сохранили тему в Prefs (туда, куда умеет сохранять ApiUtil через репозиторий с SusaninData todo это не проверено
      yield DataStateThemeToggled();
    }
  }
}
