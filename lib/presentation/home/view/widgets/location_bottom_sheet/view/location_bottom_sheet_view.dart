part of '../location_bottom_sheet.dart';

class _LocationBottomSheetView extends StatefulWidget {
  const _LocationBottomSheetView({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.saveLocation,
  });
  final String name;
  final String latitude;
  final String longitude;
  final Future<void> Function({
    required String latitude,
    required String longitude,
    required String name,
  }) saveLocation;

  @override
  State<_LocationBottomSheetView> createState() =>
      _LocationBottomSheetViewState();
}

class _LocationBottomSheetViewState extends State<_LocationBottomSheetView> {
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
                    TextField(
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
                    TextField(
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
                    TextField(
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
