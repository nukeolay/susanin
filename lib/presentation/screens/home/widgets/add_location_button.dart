import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_cubit.dart';
import 'package:susanin/presentation/bloc/add_location_cubit/add_location_state.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_state.dart';
import 'package:susanin/presentation/screens/home/widgets/location_bottom_sheet.dart';

class AddNewLocationButton extends StatelessWidget {
  const AddNewLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddLocationCubit, AddLocationState>(
      listenWhen: ((previous, current) {
        return current.status == AddLocationStatus.editing;
      }),
      listener: ((context, state) {
        _showBottomSheet(context, state);
      }),
      builder: ((context, state) {
        if (state.status == AddLocationStatus.loading) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.green,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else if (state.status == AddLocationStatus.failure) {
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.grey,
            child: Icon(Icons.not_interested_rounded),
          );
        }
        return GestureDetector(
          onLongPress: () {
            context.read<AddLocationCubit>().onLongPressAdd();
          },
          child: FloatingActionButton(
            onPressed: () => context.read<AddLocationCubit>().onPressAdd(),
            backgroundColor: Colors.green,
            child: const Icon(Icons.add_location_alt_rounded),
          ),
        );
      }),
    );
  }

  void _showBottomSheet(BuildContext context, AddLocationState state) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<LocationPointValidateBloc,
            LocationPointValidateState>(builder: (context, validatorState) {
          return LocationBottomSheet(
            name: state.pointName,
            latitude: state.latitude.toString(),
            longitude: state.longitude.toString(),
            flushValidator: () =>
                context.read<LocationPointValidateBloc>().add(FlushValidator()),
            nameValidator: (String value) => context
                .read<LocationPointValidateBloc>()
                .add(NameChanged(name: value)),
            latitudeValidator: (String value) => context
                .read<LocationPointValidateBloc>()
                .add(LatitudeChanged(latitude: value)),
            longitudeValidator: (String value) => context
                .read<LocationPointValidateBloc>()
                .add(LongitudeChanged(longitude: value)),
            saveLocation: (
              String latitude,
              String longitude,
              String name,
            ) {
              context.read<AddLocationCubit>().onSaveLocation(
                    latitude: double.parse(latitude),
                    longitude: double.parse(longitude),
                    pointName: name,
                  );
            },
            isNameValid: validatorState.isNameValid,
            isLatutideValid: validatorState.isLatutideValid,
            isLongitudeValid: validatorState.isLongitudeValid,
          );
        });
      },
    );
  }
}
