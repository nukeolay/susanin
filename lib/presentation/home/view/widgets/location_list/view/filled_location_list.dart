import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/routes/routes.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/presentation/common/remove_location_dialog.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/cubit/locations_list_cubit.dart';
import 'package:susanin/presentation/home/view/widgets/location_list/view/location_list_item.dart';

class FilledLocationList extends StatefulWidget {
  const FilledLocationList({required this.topPadding, super.key});
  final double topPadding;

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
    return BlocBuilder<LocationsListCubit, LocationsListState>(
      builder: (context, state) {
        final places = state.places;
        if (places.length > initialLength) {
          animatedListKey.currentState!.insertItem(0);
        } else if (places.length < initialLength) {
          _removeItems(state.removedItems);
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
              onPress: () => _onPressed(place.id, state.activePlaceId),
              onLongPress: () => _onLongPressed(place.id),
              onDismissed: (_) => _onDismissed(place.id),
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

  void _onPressed(String id, String activeId) {
    HapticFeedback.heavyImpact();
    if (id == activeId) {
      Navigator.of(context).pushNamed(
        Routes.detailedLocationInfo,
        arguments: [activeId],
      );
    } else {
      final cubit = context.read<LocationsListCubit>();
      cubit.onPressed(id: id);
    }
  }

  void _onLongPressed(String id) {
    final cubit = context.read<LocationsListCubit>();
    cubit.onLongPressEdit(id: id);
  }

  void _removeItems(List<PlaceEntity> removedPlaces) {
    for (final place in removedPlaces) {
      final cubit = context.read<LocationsListCubit>();
      final index = cubit.state.previousPlaces.indexOf(place);
      final invertedIndex = cubit.state.previousPlaces.length - index - 1;
      animatedListKey.currentState!.removeItem(
        invertedIndex,
        (_, __) => const SizedBox.shrink(),
      );
    }
  }

  Future<void> _onDismissed(
    String id,
  ) async {
    final cubit = context.read<LocationsListCubit>();
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
      return showRemoveConfirmationDialog(context: context);
    } else {
      HapticFeedback.heavyImpact();
      context.read<LocationsListCubit>().onShare(place);
      return false;
    }
  }
}
