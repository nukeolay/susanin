import 'package:susanin/features/compass/domain/entities/compass.dart';

class CompassModel extends CompassEntity {
  const CompassModel({
    required super.north,
    required super.accuracy,
  });
}
