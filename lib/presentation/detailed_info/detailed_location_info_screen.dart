import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/places/domain/entities/place.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';
import 'package:susanin/features/wakelock/domain/use_cases/get_wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/detailed_location_info_view.dart';

class DetailedInfoScreen extends StatelessWidget {
  const DetailedInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object>;
    final place = arguments[0] as PlaceEntity;

    final compassRepository = context.read<CompassRepository>();
    final locationRepository = context.read<LocationRepository>();
    final wakelockRepository = context.read<WakelockRepository>();

    final getCompassStream = GetCompassStream(compassRepository);
    final getPositionStream = GetPositionStream(locationRepository);
    final getWakelockStatus = GetWakelockStatus(wakelockRepository);
    final toggleWakelock = ToggleWakelock(wakelockRepository);

    return BlocProvider(
      create: (context) => DetailedInfoCubit(
        getCompassStream: getCompassStream,
        getPositionStream: getPositionStream,
        getWakelockStatus: getWakelockStatus,
        toggleWakelock: toggleWakelock,
        place: place,
      ),
      child: const DetailedInfoView(),
    );
  }
}
