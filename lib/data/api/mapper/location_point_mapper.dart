import 'package:susanin/data/api/model/api_location_point.dart';
import 'package:susanin/domain/model/location_point.dart';

class LocationPointMapper {
  static LocationPoint fromApi(ApiLocationPoint apiLocationPoint) {
    return LocationPoint(
        latitude: apiLocationPoint.latitude,
        longitude: apiLocationPoint.longitude,
        pointName: apiLocationPoint.pointName,
        creationTime: DateTime.fromMillisecondsSinceEpoch(apiLocationPoint.creationTime));
  }
}
