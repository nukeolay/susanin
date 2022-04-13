import 'package:susanin/core/usecases/usecase.dart';
import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class GetLocationServiceProperties
    extends UseCase<Future<LocationServicePropertiesEntity>> {
  final LocationServiceRepository _positionRepository;
  GetLocationServiceProperties(this._positionRepository);
  @override
  Future<LocationServicePropertiesEntity> call() {
    return _positionRepository.properties;
  }
}
