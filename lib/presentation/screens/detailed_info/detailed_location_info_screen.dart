import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/bloc/detailed_info_cubit/detailed_info_state.dart';
import 'package:susanin/presentation/screens/common_widgets/hide_button.dart';
import 'package:susanin/presentation/screens/detailed_info/widgets/location_details.dart';
import 'package:susanin/presentation/screens/home/widgets/common/pointer.dart';

class DetailedInfoScreen extends StatelessWidget {
  const DetailedInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeLocationPoint =
        ModalRoute.of(context)!.settings.arguments as LocationPointEntity;
    context.read<DetailedInfoCubit>().setActiveLocation(activeLocationPoint);
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
                    state.errorMessage,
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

          return Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (state.hasCompass)
                        Pointer(
                          rotateAngle: state.angle,
                          arcRadius: state.pointerArc,
                          positionAccuracy: state.positionAccuracy,
                          radius: radius,
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                          backGroundColor: Theme.of(context).cardColor,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          state.distance,
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Text(
                              'точность определения геолокации: ',
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                          ),
                          Text(
                            '${state.positionAccuracy.toStringAsFixed(1)} м',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      LocationDetails(
                        pointName: state.locationName,
                        pointLatitude: state.locationLatitude.toStringAsFixed(7),
                        pointLongitude:
                            state.locationLongitude.toStringAsFixed(7),
                      ),
                      const SizedBox(height: 10.0),
                      LocationDetails(
                        pointName: 'текущее местоположение',
                        pointLatitude: state.userLatitude.toStringAsFixed(7),
                        pointLongitude: state.userLongitude.toStringAsFixed(7),
                      ),
                    ],
                  )),
            ),
          );
        }),
      ),
      bottomNavigationBar: const HideButton(text: 'К выбору локаций'),
    );
  }
}
