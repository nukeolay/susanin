import 'package:susanin/domain/location/entities/location_service_properties.dart';
import 'package:susanin/domain/location/repositories/repository.dart';

class GetLocationServiceProperties {
  final LocationServiceRepository _positionRepository;
  GetLocationServiceProperties(this._positionRepository);
  Future<LocationServicePropertiesEntity> call() {
    return _positionRepository.properties;
  }
}
