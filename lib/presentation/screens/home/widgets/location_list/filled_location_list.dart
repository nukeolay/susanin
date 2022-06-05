import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:susanin/domain/location_points/entities/location_point.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
import 'package:susanin/presentation/screens/home/widgets/location_list/location_list_item.dart';

class FilledLocationList extends StatefulWidget {
  final double topPadding;

  const FilledLocationList({required this.topPadding, Key? key})
      : super(key: key);

  @override
  State<FilledLocationList> createState() => _FilledLocationListState();
}

class _FilledLocationListState extends State<FilledLocationList> {
  final animatedListKey = GlobalKey<AnimatedListState>();
  late int initialLength;
  late LocationsListState state;
  late List<LocationPointEntity> locations;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      initialLength = context.read<LocationsListCubit>().state.locations.length;
      isInit = false;
    }
    state = context.watch<LocationsListCubit>().state;
    locations = state.locations;
    if (locations.length > initialLength) {
      animatedListKey.currentState!.insertItem(0);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    initialLength = state.locations.length;
    return AnimatedList(
      key: animatedListKey,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      initialItemCount: locations.length,
      padding: EdgeInsets.only(top: widget.topPadding, bottom: 100),
      itemBuilder: (context, index, animation) {
        final invertedIndex = locations.length - index - 1;
        final location = locations[invertedIndex];
        final itemKey = ValueKey(location.id);
        final cubit = context.read<LocationsListCubit>();
        return LocationListItem(
          key: itemKey,
          location: locations[invertedIndex],
          isActive: location.id == state.activeLocationId,
          animation: animation,
          onPress: () => _onPressed(cubit, location.id),
          onLongPress: () => _onLongPressed(cubit, location.id),
          onDismissed: (value) =>
              _onDismissed(cubit, invertedIndex, location.id),
          onConfirmDismiss: (DismissDirection dismissDirection) =>
              _onConfirmDismiss(dismissDirection, invertedIndex, location),
        );
      },
    );
  }

  void _onPressed(LocationsListCubit cubit, String id) {
    HapticFeedback.heavyImpact();
    cubit.onPressSetActive(id: id);
  }

  void _onLongPressed(LocationsListCubit cubit, String id) {
    cubit.onLongPressEdit(id: id);
  }

  void _onDismissed(LocationsListCubit cubit, int index, String id) async {
    animatedListKey.currentState!.removeItem(index, (_, __) => Container());
    await cubit.onDeleteLocation(id: id);
  }

  Future<bool?> _onConfirmDismiss(
    DismissDirection dismissDirection,
    int index,
    LocationPointEntity location,
  ) async {
    if (dismissDirection == DismissDirection.startToEnd) {
      HapticFeedback.heavyImpact();
      return _showConfirmationDialog(
        context: context,
        index: index,
        isActive: location.id == state.activeLocationId,
        location: location,
      );
    } else {
      HapticFeedback.heavyImpact();
      await Share.share(
          '${location.name} https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
      return false;
    }
  }
}

Future<bool?> _showConfirmationDialog({
  required BuildContext context,
  required int index,
  required LocationPointEntity location,
  required bool isActive,
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
