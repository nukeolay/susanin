import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/screens/home/widgets/common/location_bottom_sheet.dart';
import 'package:susanin/presentation/screens/home/widgets/locations/location_list_item.dart';

class LocationList extends StatelessWidget {
  final double topPadding;
  const LocationList({required this.topPadding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<LocationsListCubit, LocationsListState>(
        listener: ((context, state) {
          if (state.status == LocationsListStatus.editing) {
            _showBottomSheet(context, state as EditLocationState);
          } else if (state.status == LocationsListStatus.failure) {
            final snackBar = SnackBar(
              content: Text('unknown_error'.tr()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }),
        builder: ((context, state) {
          if (state.status == LocationsListStatus.loading) {
            return const SingleChildScrollView(
                child: CircularProgressIndicator());
          } else if (state.locations.isEmpty) {
            return Center(
              child: Padding(
                padding:
                    EdgeInsets.only(top: topPadding, left: 12.0, right: 12.0),
                child: SingleChildScrollView(
                  child: Text(
                    'empty_locations_list'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          } else {
            final locations = state.locations;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: locations.length,
              padding: EdgeInsets.only(top: topPadding, bottom: 100),
              itemBuilder: (context, index) {
                final invertedIndex = locations.length - index - 1;
                final location = locations[invertedIndex];
                final itemKey = ValueKey(location.name);
                final cubit = context.read<LocationsListCubit>();
                return LocationListItem(
                  location: location,
                  isActive: location.id == state.activeLocationId,
                  onPress: () {
                    HapticFeedback.heavyImpact();
                    cubit.onPressSetActive(id: location.id);
                  },
                  onLongPress: () => cubit.onLongPressEdit(id: location.id),
                  onDismissed: (value) async {
                    await cubit.onDeleteLocation(id: location.id);
                  },
                  onConfirmDismiss: (DismissDirection dismissDirection) async {
                    if (dismissDirection == DismissDirection.startToEnd) {
                      HapticFeedback.heavyImpact();
                      return _showConfirmationDialog(context: context);
                    } else {
                      HapticFeedback.heavyImpact();
                      await Share.share(
                          '${location.name} https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
                      return false;
                    }
                  },
                  key: itemKey,
                );
              },
            );
          }
        }),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, EditLocationState state) async {
    final cubit = context.read<LocationsListCubit>();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LocationBottomSheet(
          name: state.name,
          latitude: state.latitude.toString(),
          longitude: state.longitude.toString(),
          saveLocation: (String latitude, String longitude, String name) async {
            await cubit.onSaveLocation(
                latitude: double.parse(latitude),
                longitude: double.parse(longitude),
                newLocationName: name,
                id: state.id);
          },
        );
      },
    );
    cubit.onBottomSheetClose();
  }
}

Future<bool?> _showConfirmationDialog({
  required BuildContext context,
}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('delete_location'.tr()),
        actions: [
          CupertinoDialogAction(
            child: Text('button_yes'.tr()),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          CupertinoDialogAction(
            child: Text('button_no'.tr()),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}
