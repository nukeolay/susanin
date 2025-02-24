import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../common/pointer.dart';
import '../../cubit/detailed_info_cubit.dart';
import 'detailed_notes.dart';
import 'edit_button.dart';
import 'location_details.dart';
import 'map_button.dart';
import 'remove_button.dart';
import 'wakelock_button.dart';

class LoadedDetails extends StatelessWidget {
  const LoadedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = MediaQuery.sizeOf(context).width * 0.7;
    return BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 76),
            physics: const BouncingScrollPhysics(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.hasCompass)
                    Stack(
                      children: [
                        Pointer(
                          rotateAngle: state.bearing,
                          arcRadius: state.pointerArc,
                          positionAccuracy: state.accuracy,
                          radius: radius,
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                          backGroundColor: Theme.of(context).cardColor,
                        ),
                        const Positioned(
                          top: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailedWakelockButton(),
                              DetailedMapButton(),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RemoveButton(
                                onRemove: () {
                                  context
                                      .read<DetailedInfoCubit>()
                                      .onDeleteLocation();
                                  Navigator.pop(context);
                                },
                              ),
                              DetailedEditButton(place: state.place),
                            ],
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      state.distance.toInt().toDistanceString(context),
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
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
                  ),
                  DetailedNotes(notes: state.notes),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LocationDetails(
                      pointName: state.locationName,
                      pointLatitude: state.locationLatitude.toStringAsFixed(7),
                      pointLongitude:
                          state.locationLongitude.toStringAsFixed(7),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LocationDetails(
                      pointName: context.s.current_location,
                      pointLatitude: state.userLatitude.toStringAsFixed(7),
                      pointLongitude: state.userLongitude.toStringAsFixed(7),
                    ),
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
