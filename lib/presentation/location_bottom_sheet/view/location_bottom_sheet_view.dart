import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/extensions.dart';
import '../../../features/places/domain/entities/icon_entity.dart';
import '../../common/snackbar_error_handler.dart';
import '../bloc/validator_bloc.dart';
import 'widgets/cancel_button.dart';
import 'widgets/icon_selector/icon_selector.dart';
import 'widgets/save_button.dart';
import 'widgets/validator_text_field.dart';

typedef PlaceCallback =
    Future<void> Function({
      required String name,
      required String notes,
      required String latitude,
      required String longitude,
      required IconEntity icon,
    });

class LocationBottomSheetView extends StatefulWidget {
  const LocationBottomSheetView({
    required this.name,
    required this.icon,
    required this.latitude,
    required this.longitude,
    required this.notes,
    required this.saveLocation,
    super.key,
  });

  final String name;
  final IconEntity icon;
  final String notes;
  final String latitude;
  final String longitude;
  final PlaceCallback saveLocation;

  @override
  State<LocationBottomSheetView> createState() =>
      _LocationBottomSheetViewState();
}

class _LocationBottomSheetViewState extends State<LocationBottomSheetView> {
  late final TextEditingController _nameController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _notesController;
  late IconEntity _icon;

  @override
  void initState() {
    _icon = widget.icon;
    _nameController = TextEditingController(text: widget.name);
    _latitudeController = TextEditingController(text: widget.latitude);
    _longitudeController = TextEditingController(text: widget.longitude);
    _notesController = TextEditingController(text: widget.notes);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationValidatorBloc>();
    return BlocBuilder<LocationValidatorBloc, LocationValidatorState>(
      builder: (context, validatorState) {
        return ListView(
          shrinkWrap: true,
          children: <Widget>[
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ValidatorTextField(
                          controller: _nameController,
                          isValid: validatorState.isNameValid,
                          label: context.s.location_name,
                          autofocus: true,
                          onChanged: (value) {
                            bloc.add(NameChanged(name: value));
                          },
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: IconButton(
                          icon: Icon(_icon.iconData, color: _icon.color),
                          iconSize: 24,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          onPressed: () async {
                            final icon = await showIconSelectorDialog(
                              context: context,
                              icon: _icon,
                            );
                            setState(() {
                              _icon = icon;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ValidatorTextField(
                          controller: _latitudeController,
                          isValid: validatorState.isLatutideValid,
                          label: context.s.latitude,
                          onChanged: (value) {
                            bloc.add(LatitudeChanged(latitude: value));
                          },
                        ),
                      ),
                      Expanded(
                        child: ValidatorTextField(
                          controller: _longitudeController,
                          isValid: validatorState.isLongitudeValid,
                          label: context.s.longitude,
                          onChanged: (value) {
                            bloc.add(LongitudeChanged(longitude: value));
                          },
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    minLines: 3,
                    maxLines: 3,
                    controller: _notesController,
                    decoration: InputDecoration(
                      labelText: context.s.notes,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Expanded(child: CancelButton()),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SaveButton(
                        isValid: validatorState.isValid,
                        onSave: () {
                          unawaited(
                            widget
                                .saveLocation(
                                  latitude: _latitudeController.text,
                                  longitude: _longitudeController.text,
                                  name: _nameController.text,
                                  notes: _notesController.text,
                                  icon: _icon,
                                )
                                .onError(SnackBarErrorHandler(context).onError),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
