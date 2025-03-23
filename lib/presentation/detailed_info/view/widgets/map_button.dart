import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../cubit/detailed_info_cubit.dart';

class DetailedMapButton extends StatelessWidget {
  const DetailedMapButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailedInfoCubit, DetailedInfoState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => MapsLauncher.launchCoordinates(
            state.locationLatitude,
            state.locationLongitude,
            state.locationName,
          ),
          icon: const Icon(Icons.map_rounded),
        );
      },
    );
  }
}
