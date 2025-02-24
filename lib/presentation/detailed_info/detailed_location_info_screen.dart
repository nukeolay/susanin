import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/compass/domain/repositories/compass_repository.dart';
import '../../features/location/domain/repositories/location_repository.dart';
import '../../features/places/domain/repositories/places_repository.dart';
import '../../features/wakelock/domain/repositories/wakelock_repository.dart';
import 'cubit/detailed_info_cubit.dart';
import 'view/detailed_location_info_view.dart';

class DetailedInfoScreen extends StatelessWidget {
  const DetailedInfoScreen({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailedInfoCubit(
        placesRepository: context.read<PlacesRepository>(),
        compassRepository: context.read<CompassRepository>(),
        locationRepository: context.read<LocationRepository>(),
        wakelockRepository: context.read<WakelockRepository>(),
        placeId: id,
      )..init(),
      child: const DetailedInfoView(),
    );
  }
}
