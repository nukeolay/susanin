import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/compass/domain/use_cases/get_compass_stream.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/features/location/domain/use_cases/request_permission.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';
import 'package:susanin/features/wakelock/domain/use_cases/get_wakelock_status.dart';
import 'package:susanin/features/wakelock/domain/use_cases/toggle_wakelock.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';
import 'package:susanin/presentation/settings/view/settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compassRepository = context.read<CompassRepository>();
    final locationRepository = context.read<LocationRepository>();
    final wakelockRepository = context.read<WakelockRepository>();

    final getCompassStream = GetCompassStream(compassRepository);
    final getPositionStream = GetPositionStream(locationRepository);
    final getWakelockStatus = GetWakelockStatus(wakelockRepository);
    final toggleWakelock = ToggleWakelock(wakelockRepository);
    final requestPermission = RequestPermission(locationRepository);

    return BlocProvider(
      create: (context) => SettingsCubit(
        getCompassStream: getCompassStream,
        getPositionStream: getPositionStream,
        getWakelockStatus: getWakelockStatus,
        toggleWakelock: toggleWakelock,
        requestPermission: requestPermission,
      ),
      child: const SettingsView(),
    );
  }
}
