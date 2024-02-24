import 'package:susanin/core/use_cases/use_case.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';

class RequestPermission extends UseCase<Future<LocationStatus>, NoParams> {
  const RequestPermission(this._locationRepository);

  final LocationRepository _locationRepository;

  @override
  Future<LocationStatus> call(NoParams params) async {
    final permission = await _locationRepository.checkPermission();
    if (permission) return LocationStatus.granted;
    final isGranted = await _locationRepository.requestPermission();
    return isGranted ? LocationStatus.granted : LocationStatus.notPermitted;
  }
}
