import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';

class LocationListItem extends StatelessWidget {
  const LocationListItem({
    required this.location,
    required this.isActive,
    required this.animation,
    required this.onPress,
    required this.onLongPress,
    required this.onDismissed,
    required this.onConfirmDismiss,
    required super.key,
  });
  final PlaceEntity location;
  final bool isActive;
  final Animation<double> animation;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final Function(DismissDirection)? onDismissed;
  final Future<bool> Function(DismissDirection)? onConfirmDismiss;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Dismissible(
        key: key!,
        background: Container(
          color: Theme.of(context).colorScheme.error,
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
        onDismissed: onDismissed,
        confirmDismiss: onConfirmDismiss,
        child: ListTile(
          selected: isActive,
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            child: const Icon(Icons.location_on_rounded),
          ),
          title: Text(
            location.name,
            style: const TextStyle(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            DateFormat('date_format'.tr()).format(location.creationTime),
          ),
          onTap: onPress,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
