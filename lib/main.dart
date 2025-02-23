import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/internal/di_provider.dart';
import 'package:susanin/internal/application.dart';
import 'package:susanin/internal/cubit/app_settings_cubit.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DiProvider(
      child: BlocProvider(
        create: (context) => AppSettingsCubit(
          settingsRepository: context.read<SettingsRepository>(),
        )..init(),
        child: const SusaninApp(),
      ),
    ),
  );
}
