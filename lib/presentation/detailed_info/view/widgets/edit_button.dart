import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/presentation/common/susanin_button.dart';
import 'package:susanin/presentation/detailed_info/cubit/detailed_info_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_bottom_sheet/location_bottom_sheet.dart';

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
              latitude: place.latitude,
              longitude: place.longitude,
              notes: place.notes,
              saveLocation: ({
                required String latitude,
                required String longitude,
                required String name,
                required String notes,
              }) =>
                  context.read<DetailedInfoCubit>().onSaveLocation(
                        latitude: latitude,
                        longitude: longitude,
                        notes: notes,
                        newLocationName: name,
                      ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SusaninButton(
        label: context.s.button_edit_location,
        type: ButtonType.primary,
        onPressed: () => _showBottomSheet(context),
      ),
    );
  }
}
