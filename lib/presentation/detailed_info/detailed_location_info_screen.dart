import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/detailed_location_info_view.dart';

class DetailedInfoScreen extends StatelessWidget {
  const DetailedInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments! as List<Object>;
    final placeId = arguments[0] as String;
    return BlocProvider(
      create: (context) => DetailedInfoCubit(
        placesRepository: context.read<PlacesRepository>(),
        compassRepository: context.read<CompassRepository>(),
        locationRepository: context.read<LocationRepository>(),
        wakelockRepository: context.read<WakelockRepository>(),
        placeId: placeId,
      )..init(),
      child: const DetailedInfoView(),
    );
  }
}
