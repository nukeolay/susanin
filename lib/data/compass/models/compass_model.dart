import 'package:susanin/domain/compass/entities/compass.dart';

class CompassModel extends CompassEntity {
  const CompassModel({
    required double north,
    required double accuracy,
  }) : super(
          north: north,
          accuracy: accuracy,
        );
}
