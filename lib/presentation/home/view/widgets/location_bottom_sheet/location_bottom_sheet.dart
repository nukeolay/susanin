import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/common/widgets/glass_bottom_sheet.dart';
import 'package:susanin/presentation/common/widgets/glass_button.dart';
import 'package:susanin/presentation/home/view/widgets/location_bottom_sheet/bloc/validator_bloc.dart';

part 'view/location_bottom_sheet_view.dart';
part 'view/widgets/save_button.dart';
part 'view/widgets/cancel_button.dart';

class LocationBottomSheetModel {
  const LocationBottomSheetModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.saveLocation,
  });

  final String name;
  final double latitude;
  final double longitude;
  final Future<void> Function({
    required String latitude,
    required String longitude,
    required String name,
  }) saveLocation;
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
      child: _LocationBottomSheetView(
        latitude: model.latitude.toString(),
        longitude: model.longitude.toString(),
        name: model.name,
        saveLocation: model.saveLocation,
      ),
    );
  }
}
