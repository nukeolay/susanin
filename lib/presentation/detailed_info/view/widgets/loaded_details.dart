import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/presentation/common/pointer.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/detailed_notes.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/edit_button.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/location_details.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/map_button.dart';
import 'package:susanin/presentation/detailed_info/view/widgets/wakelock_button.dart';

class LoadedDetails extends StatelessWidget {
  const LoadedDetails({super.key});

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
                          pointLatitude:
                              state.locationLatitude.toStringAsFixed(7),
                          pointLongitude:
                              state.locationLongitude.toStringAsFixed(7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: LocationDetails(
                          pointName: context.s.current_location,
                          pointLatitude: state.userLatitude.toStringAsFixed(7),
                          pointLongitude:
                              state.userLongitude.toStringAsFixed(7),
                        ),
                      ),
                      DetailedEditButton(place: state.place),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailedWakelockButton(),
                      DetailedMapButton(),
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
