import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/common/widgets/custom_bottom_sheet.dart';
import 'package:susanin/presentation/home/view/widgets/location_bottom_sheet/bloc/validator_bloc.dart';

class LocationBottomSheet extends StatefulWidget {
  final String name;
  final String latitude;
  final String longitude;
  final Future<void> Function({
    required String latitude,
    required String longitude,
    required String name,
  }) saveLocation;

  const LocationBottomSheet({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.saveLocation,
    super.key,
  });

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _latitudeController;
  late final TextEditingController _longitudeController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _latitudeController = TextEditingController(text: widget.latitude);
    _longitudeController = TextEditingController(text: widget.longitude);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationValidatorBloc>();
    return CustomBottomSheet(
      child: BlocBuilder<LocationValidatorBloc, LocationValidatorState>(
        builder: (context, validatorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 40,
                height: 7,
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'location_name'.tr(),
                        errorText: !validatorState.isNameValid
                            ? 'enter_name'.tr()
                            : null,
                      ),
                      onChanged: (value) {
                        bloc.add(NameChanged(name: value));
                      },
                    ),
                    TextFormField(
                      controller: _latitudeController,
                      decoration: InputDecoration(
                        labelText: 'latitude'.tr(),
                        errorText: !validatorState.isLatutideValid
                            ? 'incorrect_value'.tr()
                            : null,
                      ),
                      onChanged: (value) {
                        bloc.add(LatitudeChanged(latitude: value));
                      },
                    ),
                    TextFormField(
                      controller: _longitudeController,
                      decoration: InputDecoration(
                        labelText: 'longitude'.tr(),
                        errorText: !validatorState.isLongitudeValid
                            ? 'incorrect_value'.tr()
                            : null,
                      ),
                      onChanged: (value) {
                        bloc.add(LongitudeChanged(longitude: value));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const _CancelButton(),
                    _SaveButton(
                      isValid: validatorState.isValid,
                      onSave: () {
                        widget.saveLocation(
                          latitude: _latitudeController.text,
                          longitude: _longitudeController.text,
                          name: _nameController.text,
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.isValid,
    required this.onSave,
  });

  final bool isValid;
  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        foregroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.inversePrimary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: isValid ? onSave : null,
      child: Text('button_save'.tr()),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('button_cancel'.tr()),
    );
  }
}
