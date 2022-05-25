import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/location_bottom_sheet.dart';
import 'package:susanin/presentation/screens/home/widgets/locations/location_list_item.dart';

class LocationAnimatedList extends StatelessWidget {
  final double topPadding;
  const LocationAnimatedList({required this.topPadding, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<LocationsListCubit, LocationsListState>(
        listener: ((context, state) {
          if (state.status == LocationsListStatus.editing) {
            _showBottomSheet(context, state as EditLocationState);
          } else if (state.status == LocationsListStatus.failure) {
            const snackBar = SnackBar(
              content: Text('Ошибка при выполнении действия'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }),
        builder: ((context, state) {
          if (state.status == LocationsListStatus.loading) {
            return const SingleChildScrollView(
                child: CircularProgressIndicator());
          } else if (state.locations.isEmpty) {
            return const Center(
                child: Text(
              'Нет сохраненных локаций',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ));
          } else {
            final locations = state.locations;
            return AnimatedList(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              initialItemCount: locations.length,
              padding: EdgeInsets.only(top: topPadding, bottom: 100),
              itemBuilder: (context, index, animation) {
                final key =
                    ValueKey(locations[locations.length - index - 1].name);
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: LocationListItem(
                    location: locations[locations.length - index - 1],
                    isActive: locations[locations.length - index - 1].id ==
                        state.activeLocationId,
                    key: key,
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EditLocationState state) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LocationBottomSheet(
          name: state.name,
          latitude: state.latitude.toString(),
          longitude: state.longitude.toString(),
          saveLocation: (
            String latitude,
            String longitude,
            String name,
          ) async {
            await context.read<LocationsListCubit>().onSaveLocation(
                  latitude: double.parse(latitude),
                  longitude: double.parse(longitude),
                  newLocationName: name,
                  id: state.id,
                );
          },
        );
      },
    );
    context.read<LocationsListCubit>().onBottomSheetClose();
  }
}
