import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';
import 'package:susanin/presentation/settings/cubit/settings_cubit.dart';
import 'package:susanin/presentation/settings/view/settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compassRepository = context.read<CompassRepository>();
    final locationRepository = context.read<LocationRepository>();
    final wakelockRepository = context.read<WakelockRepository>();
    return BlocProvider(
      create: (context) => SettingsCubit(
        compassRepository: compassRepository,
        locationRepository: locationRepository,
        wakelockRepository: wakelockRepository,
      )..init(),
      child: const SettingsView(),
    );
  }
}
