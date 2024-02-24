import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/location/domain/use_cases/get_position_stream.dart';
import 'package:susanin/presentation/common/widgets/hide_button.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/custom_snackbar.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/detailed_location_info.dart';

class DetailedInfoView extends StatelessWidget {
  const DetailedInfoView({super.key});

  Future<void> toggleWakeLock(BuildContext context) async {
    await context.read<DetailedInfoCubit>().toggleWakelock();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isScreenAlwaysOn =
          context.read<DetailedInfoCubit>().state.isScreenAlwaysOn;
      final snackBar = CustomSnackBar(
        content: isScreenAlwaysOn
            ? Text(
                'always_on_display_on'.tr(),
                textAlign: TextAlign.center,
              )
            : Text(
                'always_on_display_off'.tr(),
                textAlign: TextAlign.center,
              ),
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
            builder: (context, state) {
          if (state.isFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.primary,
                  highlightColor: Theme.of(context).colorScheme.error,
                  child: Text(
                    state.locationServiceStatus.toErrorMessage()?.tr() ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ],
            );
          }

          if (state.locationServiceStatus.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return DetailedLocationInfo(
            distance: state.distance.toInt().toDistanceString(),
            angle: state.bearing,
            hasCompass: state.hasCompass,
            isScreenAlwaysOn: state.isScreenAlwaysOn,
            locationLatitude: state.locationLatitude,
            locationLongitude: state.locationLongitude,
            locationName: state.locationName,
            pointerArc: state.pointerArc,
            accuracy: state.accuracy,
            radius: radius,
            userLatitude: state.userLatitude,
            userLongitude: state.userLongitude,
            toggleWakelock: () => toggleWakeLock(context),
          );
        }),
      ),
      bottomNavigationBar: HideButton(text: 'button_back_to_locations'.tr()),
    );
  }
}
