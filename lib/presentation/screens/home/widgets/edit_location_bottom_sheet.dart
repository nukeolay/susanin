import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validte_state.dart';

class EditLocationBottomSheet extends StatefulWidget {
  final String name;
  final String latitude;
  final String longitude;
  const EditLocationBottomSheet({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<EditLocationBottomSheet> createState() =>
      _EditLocationBottomSheetState();
}

class _EditLocationBottomSheetState extends State<EditLocationBottomSheet> {
  late final TextEditingController nameController;
  late final TextEditingController latitudeController;
  late final TextEditingController longitudeController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.name);
    latitudeController = TextEditingController(text: widget.latitude);
    longitudeController = TextEditingController(text: widget.longitude);
    context.read<LocationpointValidateBloc>().add(FlushValidator());
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
    return BlocBuilder<LocationpointValidateBloc, LocationPointValidateState>(
        builder: (context, state) {
      return Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Edit Location'),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Location Name',
                      errorText: !state.isNameValid
                          ? 'Location with this name exists'
                          : null,
                    ),
                    onChanged: (value) {
                      context
                          .read<LocationpointValidateBloc>()
                          .add(NameChanged(name: value));
                    },
                  ),
                  TextFormField(
                    controller: latitudeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      errorText: !state.isLatutideValid
                          ? 'Wrong latitude value'
                          : null,
                    ),
                    onChanged: (value) {
                      context
                          .read<LocationpointValidateBloc>()
                          .add(LatitudeChanged(latitude: value));
                    },
                  ),
                  TextFormField(
                    controller: longitudeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      errorText: !state.isLongitudeValid
                          ? 'Wrong longitude value'
                          : null,
                    ),
                    onChanged: (value) {
                      context
                          .read<LocationpointValidateBloc>()
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
                    onPressed: state.isNameValid &&
                            state.isLatutideValid &&
                            state.isLongitudeValid
                        ? () {
                            context.read<AddLocationCubit>().onSaveLocation(
                                  latitude:
                                      double.parse(latitudeController.text),
                                  longitude:
                                      double.parse(longitudeController.text),
                                  pointName: nameController.text,
                                );
                            Navigator.pop(context);
                          }
                        : null),
              ],
            ),
          ],
        ),
      );
    });
  }
}
