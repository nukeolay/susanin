import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../features/places/domain/entities/icon_entity.dart';
import '../../../../features/places/domain/entities/place_entity.dart';
import '../../cubit/detailed_info_cubit.dart';
import '../../../location_bottom_sheet/location_bottom_sheet.dart';

class DetailedEditButton extends StatelessWidget {
  const DetailedEditButton({required this.place, super.key});
  final PlaceEntity place;

  Future<void> _showBottomSheet(BuildContext context) =>
      context.showSusaninBottomSheet(
        context: context,
        builder: (ctx) {
          return LocationBottomSheet(
            model: LocationBottomSheetModel(
              id: place.id,
              name: place.name,
              icon: place.icon,
              latitude: place.latitude,
              longitude: place.longitude,
              notes: place.notes,
              saveLocation: ({
                required String latitude,
                required String longitude,
                required String name,
                required IconEntity icon,
                required String notes,
              }) =>
                  context.read<DetailedInfoCubit>().onSaveLocation(
                        latitude: latitude,
                        longitude: longitude,
                        notes: notes,
                        newLocationName: name,
                        icon: icon,
                      ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit_rounded),
      onPressed: () => _showBottomSheet(context),
    );
  }
}
