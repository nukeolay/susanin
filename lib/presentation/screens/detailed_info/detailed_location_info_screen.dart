import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_state.dart';
import 'package:susanin/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:susanin/presentation/screens/common_widgets/hide_button.dart';
import 'package:susanin/presentation/screens/detailed_info/widgets/custom_snackbar.dart';
import 'package:susanin/presentation/screens/detailed_info/widgets/detailed_location_info.dart';

class DetailedInfoScreen extends StatelessWidget {
  const DetailedInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeLocationPoint =
        ModalRoute.of(context)!.settings.arguments as LocationPointEntity;
    context.read<DetailedInfoCubit>().setActiveLocation(activeLocationPoint);
    final radius = MediaQuery.of(context).size.width * 0.7;

    Future<void> _toggleWakeLock() async {
      final isScreenAlwaysOn =
          await context.read<SettingsCubit>().toggleWakelock();
      final snackBar = CustomSnackBar(
          child: isScreenAlwaysOn
              ? Text('always_on_display_on'.tr(), textAlign: TextAlign.center)
              : Text('always_on_display_off'.tr(),
                  textAlign: TextAlign.center));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

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
                    state.errorMessage.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 60),
                  ),
                ),
              ],
            );
          }

          if (state.locationServiceStatus == LocationServiceStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return DetailedLocationInfo(
            angle: state.angle,
            distance: state.distance,
            hasCompass: state.hasCompass,
            isScreenAlwaysOn:
                context.watch<SettingsCubit>().state.isScreenAlwaysOn,
            locationLatitude: state.locationLatitude,
            locationLongitude: state.locationLongitude,
            locationName: state.locationName,
            pointerArc: state.pointerArc,
            positionAccuracy: state.positionAccuracy,
            radius: radius,
            userLatitude: state.userLatitude,
            userLongitude: state.userLongitude,
            toggleWakelock: _toggleWakeLock,
          );
        }),
      ),
      bottomNavigationBar: HideButton(text: 'button_back_to_locations'.tr()),
    );
  }
}
