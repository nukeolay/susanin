import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/core/services/local_storage.dart';
import 'package:susanin/features/compass/data/repositories/compass_repository_impl.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/data/repositories/location_repository_impl.dart';
import 'package:susanin/features/location/data/services/location_service.dart';
import 'package:susanin/features/location/data/services/permission_service.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/data/repositories/places_repository_impl.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/features/wakelock/data/repositories/wakelock_repository_impl.dart';
import 'package:susanin/features/wakelock/data/services/wakelock_service.dart';
import 'package:susanin/features/wakelock/domain/repositories/wakelock_repository.dart';

class DiProvider extends StatelessWidget {
  const DiProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalStorage>(
          create: (_) => LocalStorageImpl(),
        ),
        RepositoryProvider<LocationService>(
          create: (_) => LocationServiceImpl(),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepositoryImpl(
            locationService: context.read<LocationService>(),
            permissionService: const PermissionServiceImpl(),
          ),
        ),
        RepositoryProvider<CompassRepository>(
          create: (_) => CompassRepositoryImpl(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (context) => PlacesRepositoryImpl(
            context.read<LocalStorage>(),
          ),
        ),
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepositoryImpl(
            context.read<LocalStorage>(),
          ),
        ),
        RepositoryProvider<WakelockRepository>(
          create: (context) => WakelockRepositoryImpl(
            const WakelockServiceImpl(),
          ),
        ),
      ],
      child: child,
    );
  }
}
