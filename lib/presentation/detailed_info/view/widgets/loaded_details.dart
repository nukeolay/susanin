import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/common/widgets/pointer.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/common/components/susanin_snackbar.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/detailed_notes.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/location_details.dart';

class LoadedDetails extends StatelessWidget {
  const LoadedDetails({super.key});

  Future<void> _toggleWakeLock(BuildContext context) async {
    await context.read<DetailedInfoCubit>().toggleWakelock();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isScreenAlwaysOn =
          context.read<DetailedInfoCubit>().state.isScreenAlwaysOn;
      final snackBar = SusaninSnackBar(
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
    return BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              bottom: 112,
            ),
            physics: const BouncingScrollPhysics(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (state.hasCompass)
                        Pointer(
                          rotateAngle: state.bearing,
                          arcRadius: state.pointerArc,
                          positionAccuracy: state.accuracy,
                          radius: radius,
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                          backGroundColor: Theme.of(context).cardColor,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          state.distance.toInt().toDistanceString(context),
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              context.s.accuracy_details,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            context.s.distance_meters(
                              state.accuracy.toStringAsFixed(0),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      DetailedNotes(notes: state.notes),
                      const SizedBox(height: 10.0),
                      LocationDetails(
                        pointName: state.locationName,
                        pointLatitude:
                            state.locationLatitude.toStringAsFixed(7),
                        pointLongitude:
                            state.locationLongitude.toStringAsFixed(7),
                      ),
                      const SizedBox(height: 10.0),
                      LocationDetails(
                        pointName: context.s.current_location,
                        pointLatitude: state.userLatitude.toStringAsFixed(7),
                        pointLongitude: state.userLongitude.toStringAsFixed(7),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => _toggleWakeLock(context),
                        enableFeedback: true,
                        tooltip: context.s.always_on_display,
                        icon: state.isScreenAlwaysOn
                            ? const Icon(Icons.lightbulb)
                            : const Icon(Icons.lightbulb_outline),
                      ),
                      IconButton(
                        onPressed: () => MapsLauncher.launchCoordinates(
                          state.locationLatitude,
                          state.locationLongitude,
                          state.locationName,
                        ),
                        icon: const Icon(Icons.map_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
