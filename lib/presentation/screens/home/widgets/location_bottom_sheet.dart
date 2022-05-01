import 'package:flutter/material.dart';

class LocationBottomSheet extends StatefulWidget {
  final String name;
  final String latitude;
  final String longitude;
  final Function flushValidator;
  final Function nameValidator;
  final Function latitudeValidator;
  final Function longitudeValidator;
  final Function saveLocation;
  final bool isNameValid;
  final bool isLatutideValid;
  final bool isLongitudeValid;

  const LocationBottomSheet({
    Key? key,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.flushValidator,
    required this.nameValidator,
    required this.latitudeValidator,
    required this.longitudeValidator,
    required this.saveLocation,
    required this.isNameValid,
    required this.isLatutideValid,
    required this.isLongitudeValid,
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
    widget.flushValidator();
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
        child: Column(
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
                      errorText: !widget.isNameValid
                          ? 'Location with this name exists'
                          : null,
                    ),
                    onChanged: (value) {
                      widget.nameValidator(value);
                    },
                  ),
                  TextFormField(
                    controller: latitudeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      errorText: !widget.isLatutideValid
                          ? 'Wrong latitude value'
                          : null,
                    ),
                    onChanged: (value) {
                      widget.latitudeValidator(value);
                    },
                  ),
                  TextFormField(
                    controller: longitudeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      errorText: !widget.isLongitudeValid
                          ? 'Wrong longitude value'
                          : null,
                    ),
                    onChanged: (value) {
                      widget.longitudeValidator(value);
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
                    onPressed: widget.isNameValid &&
                            widget.isLatutideValid &&
                            widget.isLongitudeValid
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
        ),
      ),
    );
  }
}
