import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/compass/domain/repositories/compass_repository.dart';
import 'package:susanin/features/location/domain/repositories/location_repository.dart';
import 'package:susanin/features/settings/domain/repositories/settings_repository.dart';
import 'package:susanin/presentation/common/widgets/pointer.dart';
import 'package:susanin/presentation/tutorial/view/slides/3_demo_pointer/cubit/demo_pointer_cubit.dart';

class DemoPointer extends StatelessWidget {
  const DemoPointer({super.key});

  @override
  Widget build(BuildContext context) {
    final compassRepository = context.read<CompassRepository>();
    final locationRepository = context.read<LocationRepository>();
    final settingsRepository = context.read<SettingsRepository>();

    return BlocProvider(
      create: (context) => DemoPointerCubit(
        compassRepository: compassRepository,
        locationRepository: locationRepository,
        settingsRepository: settingsRepository,
      ),
      child: const _DemoPointerView(),
    );
  }
}

class _DemoPointerView extends StatelessWidget {
  const _DemoPointerView();

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.sizeOf(context).width * 0.35;
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<DemoPointerCubit, DemoPointerState>(
          builder: (context, state) {
            if (state.isFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.inversePrimary,
                    highlightColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      state.locationServiceStatus.toErrorMessage(context) ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              );
            }
            if (state.locationServiceStatus.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.hasCompass)
                  Pointer(
                    rotateAngle: state.bearing,
                    arcRadius: state.pointerArc,
                    positionAccuracy: state.accuracy,
                    radius: radius,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backGroundColor: Theme.of(context).cardColor,
                  ),
                Text(
                  state.distance.toInt().toDistanceString(context),
                  style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
