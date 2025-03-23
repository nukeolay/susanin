import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internal/di_provider.dart';
import 'internal/application.dart';
import 'internal/cubit/app_settings_cubit.dart';
import 'features/settings/domain/repositories/settings_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DiProvider(
      child: BlocProvider(
        create:
            (context) => AppSettingsCubit(
              settingsRepository: context.read<SettingsRepository>(),
            )..init(),
        child: const SusaninApp(),
      ),
    ),
  );
}
