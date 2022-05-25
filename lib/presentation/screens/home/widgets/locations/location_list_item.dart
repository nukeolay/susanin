import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';

class LocationListItem extends StatelessWidget {
  final LocationPointEntity location;
  final bool isActive;

  const LocationListItem({
    required this.location,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15.0),
        child: Icon(
          Icons.delete_forever_rounded,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      secondaryBackground: Container(
        color: Theme.of(context).primaryColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15.0),
        child: Icon(
          Icons.share_rounded,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      onDismissed: (value) async {
        await context
            .read<LocationsListCubit>()
            .onDeleteLocation(id: location.id);
      },
      confirmDismiss: (DismissDirection dismissDirection) async {
        if (dismissDirection == DismissDirection.startToEnd) {
          HapticFeedback.heavyImpact();
          return _showConfirmationDialog(context);
        } else {
          HapticFeedback.heavyImpact();
          await Share.share(
              '${location.name} https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
          return false;
        }
      },
      child: ListTile(
        selected: isActive,
        leading: CircleAvatar(
          radius: 25,
          child: const Icon(Icons.location_on_rounded),
          backgroundColor: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).disabledColor,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          location.name,
          style: const TextStyle(fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Text(DateFormat('date_format'.tr()).format(location.creationTime)),
        onTap: () {
          HapticFeedback.heavyImpact();
          context.read<LocationsListCubit>().onPressSetActive(id: location.id);
        },
        onLongPress: () =>
            context.read<LocationsListCubit>().onLongPressEdit(id: location.id),
      ),
    );
  }
}

Future<bool?> _showConfirmationDialog(BuildContext context) async {
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
