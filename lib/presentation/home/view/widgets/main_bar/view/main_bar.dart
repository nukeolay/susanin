import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/places/domain/repositories/places_repository.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/cubit/main_pointer_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/view/main_bar_background.dart';
import 'package:susanin/presentation/home/view/widgets/main_bar/view/main_bar_foreground.dart';

class MainBar extends StatelessWidget {
  const MainBar({super.key});

  @override
  Widget build(BuildContext context) {
    final placesRepository = context.read<PlacesRepository>();
    final locationRepository = context.read<LocationRepository>();
    final compassRepository = context.read<CompassRepository>();
    return Expanded(
      child: Stack(
        children: [
          const MainBarBackground(),
          BlocProvider(
            create: (context) => MainPointerCubit(
              compassRepository: compassRepository,
              locationRepository: locationRepository,
              placesRepository: placesRepository,
            )..init(),
            child: const MainBarForeground(),
          ),
        ],
      ),
    );
  }
}
