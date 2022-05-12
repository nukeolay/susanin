import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate_bloc/location_point_validate_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/custom_bottom_sheet.dart';

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
    return CustomBottomSheet(
      child: BlocBuilder<LocationPointValidateBloc, LocationPointValidateState>(
          builder: (context, validatorState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
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
                      labelText: 'Название локации',
                      errorText: !validatorState.isNameValid
                          ? 'Пожалуйста, введите название'
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
                      labelText: 'Широта',
                      errorText: !validatorState.isLatutideValid
                          ? 'Некорректное значение'
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
                      labelText: 'Долгота',
                      errorText: !validatorState.isLongitudeValid
                          ? 'Некорректное значение'
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: const Text('Отмена'),
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
                      onPressed: () => Navigator.pop(context)),
                  ElevatedButton(
                      child: const Text('Сохранить'),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
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
            ),
          ],
        );
      }),
    );
  }
}
