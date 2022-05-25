import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class HollywoodPointer extends StatelessWidget {
  const HollywoodPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeLocationPoint = LocationPointEntity(
      id: '',
      latitude: 34.134057,
      longitude: -118.321569,
      name: 'Hollywood',
      creationTime: DateTime.now(),
    );
    context.read<DetailedInfoCubit>().setActiveLocation(activeLocationPoint);
    final radius = MediaQuery.of(context).size.width * 0.35;
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
            builder: (context, state) {
          if (state.isFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.inversePrimary,
                  highlightColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    state.errorMessage.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ],
            );
          }
          if (state.locationServiceStatus == LocationServiceStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (state.hasCompass)
                Pointer(
                  rotateAngle: state.angle,
                  arcRadius: state.pointerArc,
                  positionAccuracy: state.positionAccuracy,
                  radius: radius,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  backGroundColor: Theme.of(context).cardColor,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Text(
                  state.distance,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
