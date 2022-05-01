import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_bloc.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_event.dart';
import 'package:susanin/presentation/bloc/location_point_validate/location_point_validate_state.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/screens/home/widgets/location_bottom_sheet.dart';
import 'package:susanin/presentation/screens/home/widgets/location_list_item.dart';

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: BlocConsumer<LocationsListCubit, LocationsListState>(
          listenWhen: ((previous, current) {
            return current is EditLocationState &&
                current.status == LocationsListStatus.editing;
          }),
          listener: ((context, state) {
            _showBottomSheet(context, state as EditLocationState);
          }),
          builder: ((context, state) {
            if (state.status == LocationsListStatus.loading) {
              return const CircularProgressIndicator();
            } else if (state.status == LocationsListStatus.loadFailure ||
                state.status == LocationsListStatus.removeFailure ||
                state.status == LocationsListStatus.updateFailure ||
                state.status == LocationsListStatus.locationAddFailure ||
                state.status == LocationsListStatus.locationExistsFailure) {
              return Text(state.status
                  .toString()); // ! TODO моедт некоторые статусы не нужны,
            } else if (state.locations.isEmpty) {
              return const Text('There is no locations saved');
            } else {
              final locations = state.locations;
              return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final key = ValueKey(
                        locations[locations.length - index - 1].pointName);
                    return LocationListItem(
                      location: locations[locations.length - index - 1],
                      key: key,
                    );
                  });
            }
          }),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EditLocationState state) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<EditLocationPointValidateBloc,
            LocationPointValidateState>(builder: (context, validatorState) {
          return LocationBottomSheet(
            name: state.pointName,
            latitude: state.latitude.toString(),
            longitude: state.longitude.toString(),
            flushValidator: () => context
                .read<EditLocationPointValidateBloc>()
                .add(FlushValidator()),
            nameValidator: (String value) => context
                .read<EditLocationPointValidateBloc>()
                .add(NameChanged(name: value, oldName: state.pointName)),
            latitudeValidator: (String value) => context
                .read<EditLocationPointValidateBloc>()
                .add(LatitudeChanged(latitude: value)),
            longitudeValidator: (String value) => context
                .read<EditLocationPointValidateBloc>()
                .add(LongitudeChanged(longitude: value)),
            saveLocation: (
              String latitude,
              String longitude,
              String name,
            ) {
              context.read<LocationsListCubit>().onSaveLocation(
                    latitude: double.parse(latitude),
                    longitude: double.parse(longitude),
                    oldLocationName: state.pointName,
                    newLocationName: name,
                  );
            },
            isNameValid: validatorState.isNameValid,
            isLatutideValid: validatorState.isLatutideValid,
            isLongitudeValid: validatorState.isLongitudeValid,
          );
        });
      },
    );
    context.read<LocationsListCubit>().onBottomSheetClose();
  }
}
