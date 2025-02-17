import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:susanin/presentation/location_bottom_sheet/bloc/validator_bloc.dart';
import 'package:susanin/presentation/location_bottom_sheet/view/location_bottom_sheet_view.dart';

class LocationBottomSheetModel {
  const LocationBottomSheetModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.saveLocation,
    required this.notes,
  });

  final String? id;
  final String name;
  final double latitude;
  final double longitude;
  final String notes;
  final PlaceCallback saveLocation;
}

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({
    required this.model,
    super.key,
  });

  final LocationBottomSheetModel model;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationValidatorBloc(),
      child: LocationBottomSheetView(
        latitude: model.latitude.toString(),
        longitude: model.longitude.toString(),
        name: model.name,
        notes: model.notes,
        saveLocation: model.saveLocation,
      ),
    );
  }
}
