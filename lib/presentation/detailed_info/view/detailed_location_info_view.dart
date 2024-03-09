import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/common/widgets/hide_button.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/custom_snackbar.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/error_details.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/loaded_details.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/loading_details.dart';

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
                context.s.always_on_display_on,
                textAlign: TextAlign.center,
              )
            : Text(
                context.s.always_on_display_off,
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
      body: Stack(
        children: [
          BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
            builder: (context, state) {
              if (state.locationServiceStatus.isFailure) {
                return ErrorDetails(
                  locationServiceStatus: state.locationServiceStatus,
                );
              }
              if (state.locationServiceStatus.isLoading) {
                return const LoadingDetails();
              }
              return LoadedDetails(
                distance: state.distance.toInt().toDistanceString(context),
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
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).viewPadding.bottom,
            left: 0,
            right: 0,
            child: HideButton(text: context.s.button_back_to_locations),
          ),
        ],
      ),
    );
  }
}
