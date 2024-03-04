import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/location_list_item.dart';

class FilledLocationList extends StatefulWidget {
  final double topPadding;

  const FilledLocationList({required this.topPadding, super.key});

  @override
  State<FilledLocationList> createState() => _FilledLocationListState();
}

class _FilledLocationListState extends State<FilledLocationList> {
  final animatedListKey = GlobalKey<AnimatedListState>();
  late int initialLength;

  @override
  void initState() {
    initialLength = context.read<LocationsListCubit>().state.places.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocationsListCubit>();
    return BlocBuilder<LocationsListCubit, LocationsListState>(
      builder: (context, state) {
        final places = state.places;
        if (places.length > initialLength) {
          animatedListKey.currentState!.insertItem(0);
        }
        initialLength = state.places.length;
        return AnimatedList(
          key: animatedListKey,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          initialItemCount: places.length,
          padding: EdgeInsets.only(top: widget.topPadding, bottom: 100),
          itemBuilder: (context, index, animation) {
            final invertedIndex = places.length - index - 1;
            final place = places[invertedIndex];
            final itemKey = ValueKey(place.id);
            return LocationListItem(
              key: itemKey,
              location: places[invertedIndex],
              isActive: place.id == state.activePlaceId,
              animation: animation,
              onPress: () => _onPressed(cubit, place.id),
              onLongPress: () => _onLongPressed(cubit, place.id),
              onDismissed: (_) => _onDismissed(cubit, invertedIndex, place.id),
              onConfirmDismiss: (DismissDirection dismissDirection) =>
                  _onConfirmDismiss(
                dismissDirection: dismissDirection,
                index: invertedIndex,
                place: place,
                isActive: place.id == state.activePlaceId,
              ),
            );
          },
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
    animatedListKey.currentState!.removeItem(
      index,
      (_, __) => Container(),
    );
    await cubit.onDeleteLocation(id: id);
  }

  Future<bool> _onConfirmDismiss({
    required DismissDirection dismissDirection,
    required int index,
    required PlaceEntity place,
    required bool isActive,
  }) async {
    if (dismissDirection == DismissDirection.startToEnd) {
      HapticFeedback.heavyImpact();
      return _showRemoveConfirmationDialog(
        context: context,
        index: index,
        isActive: isActive,
        location: place,
      );
    } else {
      HapticFeedback.heavyImpact();
      context.read<LocationsListCubit>().onShare(place);
      return false;
    }
  }
}

Future<bool> _showRemoveConfirmationDialog({
  required BuildContext context,
  required int index,
  required PlaceEntity location,
  required bool isActive,
}) async {
  final result = await showDialog<bool>(
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
      ) ??
      false;
  return result;
}
