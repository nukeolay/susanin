import 'package:susanin/data/repository/susanin_data_repository.dart';
import 'package:susanin/domain/repository/susanin_repository.dart';

import 'api_module.dart';

class RepositoryModule {
  static SusaninRepository _susaninRepository;

  static SusaninRepository susaninRepository() {
    if (_susaninRepository == null) {
      _susaninRepository = SusaninDataRepository(
        ApiModule.apiUtil(),
      );
    }
    return _susaninRepository;
  }
}