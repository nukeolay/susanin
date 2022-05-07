import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_state.dart';

class LocationBottomSheet extends StatefulWidget {
  final String name;
  final String latitude;
  final String longitude;
  final Function saveLocation;

  const LocationBottomSheet({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.saveLocation,
  }) : super(key: key);

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  late final TextEditingController nameController;
  late final TextEditingController latitudeController;
  late final TextEditingController longitudeController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    latitudeController = TextEditingController(text: widget.latitude);
    longitudeController = TextEditingController(text: widget.longitude);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          left: 8.0,
          right: 8.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
          color: Colors.white,
        ),
        child:
            BlocBuilder<LocationPointValidateBloc, LocationPointValidateState>(
                builder: (context, validatorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20.0)),
                width: 40,
                height: 7,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Location Name',
                        errorText: !validatorState.isNameValid
                            ? 'Please enter location name'
                            : null,
                      ),
                      onChanged: (value) {
                        context
                            .read<LocationPointValidateBloc>()
                            .add(NameChanged(name: value));
                      },
                    ),
                    TextFormField(
                      controller: latitudeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Latitude',
                        errorText: !validatorState.isLatutideValid
                            ? 'Wrong latitude value'
                            : null,
                      ),
                      onChanged: (value) {
                        context
                            .read<LocationPointValidateBloc>()
                            .add(LatitudeChanged(latitude: value));
                      },
                    ),
                    TextFormField(
                      controller: longitudeController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Longitude',
                        errorText: !validatorState.isLongitudeValid
                            ? 'Wrong longitude value'
                            : null,
                      ),
                      onChanged: (value) {
                        context
                            .read<LocationPointValidateBloc>()
                            .add(LongitudeChanged(longitude: value));
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context)),
                  ElevatedButton(
                      child: const Text('Save'),
                      onPressed: validatorState.isNameValid &&
                              validatorState.isLatutideValid &&
                              validatorState.isLongitudeValid
                          ? () {
                              widget.saveLocation(
                                latitudeController.text,
                                longitudeController.text,
                                nameController.text,
                              );
                              Navigator.pop(context);
                            }
                          : null),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
