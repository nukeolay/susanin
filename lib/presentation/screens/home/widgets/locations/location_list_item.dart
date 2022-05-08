import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 15.0),
        child: const Icon(Icons.delete_forever_rounded, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15.0),
        child: const Icon(Icons.share_rounded, color: Colors.white),
      ),
      onDismissed: (value) async {
        await context
            .read<LocationsListCubit>()
            .onDeleteLocation(id: location.id);
      },
      confirmDismiss: (DismissDirection dismissDirection) async {
        if (dismissDirection == DismissDirection.startToEnd) {
          HapticFeedback.vibrate();
          return _showConfirmationDialog(context);
        } else {
          HapticFeedback.vibrate();
          await Share.share(
              '${location.name} https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
          return false;
        }
      },
      child: ListTile(
        selected: isActive,
        leading: CircleAvatar(
          child: const Icon(Icons.location_on_rounded),
          backgroundColor: isActive ? Colors.green : Colors.grey,
          foregroundColor: Colors.white,
        ),
        title: Text(
          location.name,
          style: const TextStyle(fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(DateFormat('dd-MM-yyy').format(location.creationTime)),
        onTap: () => context
            .read<LocationsListCubit>()
            .onPressSetActive(id: location.id),
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
        title: const Text('Do you want to delete this location?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}
