import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/local_storage.dart';
import '../features/compass/data/repositories/compass_repository_impl.dart';
import '../features/compass/domain/repositories/compass_repository.dart';
import '../features/location/data/repositories/location_repository_impl.dart';
import '../features/location/data/services/location_service.dart';
import '../features/location/data/services/permission_service.dart';
import '../features/location/domain/repositories/location_repository.dart';
import '../features/places/data/repositories/places_repository_impl.dart';
import '../features/places/domain/repositories/places_repository.dart';
import '../features/review/data/review_repository_impl.dart';
import '../features/review/domain/review_repository.dart';
import '../features/settings/data/repositories/settings_repository_impl.dart';
import '../features/settings/domain/repositories/settings_repository.dart';
import '../features/wakelock/data/repositories/wakelock_repository_impl.dart';
import '../features/wakelock/data/services/wakelock_service.dart';
import '../features/wakelock/domain/repositories/wakelock_repository.dart';

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
        RepositoryProvider<ReviewRepository>(
          create: (context) => ReviewRepositoryImpl(
            localStrorage: context.read<LocalStorage>(),
            androidAppId: 'com.qumyz.susanin',
            iosAppId: 'id1624344201',
          ),
        ),
      ],
      child: child,
    );
  }
}
