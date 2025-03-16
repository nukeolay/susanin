import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/navigation/routes.dart';
import '../../../../../../features/places/domain/entities/place_entity.dart';
import '../../../../../common/remove_location_dialog.dart';
import '../cubit/locations_list_cubit.dart';
import 'location_list_item.dart';

class FilledLocationList extends StatefulWidget {
  const FilledLocationList({super.key});

  @override
  State<FilledLocationList> createState() => _FilledLocationListState();
}

class _FilledLocationListState extends State<FilledLocationList> {
  late final GlobalKey<AnimatedListState> animatedListKey;

  @override
  void initState() {
    animatedListKey = GlobalKey<AnimatedListState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    return BlocBuilder<LocationsListCubit, LocationsListState>(
      builder: (context, state) {
        if (state is! LocationsListLoadedState) {
          return const SizedBox();
        }
        final places = state.places;
        if (state.places.length > state.previousPlaces.length) {
          animatedListKey.currentState?.insertItem(0);
        }
        return AnimatedList(
          key: animatedListKey,
          physics: const BouncingScrollPhysics(),
          initialItemCount: places.length,
          padding: EdgeInsets.only(top: appHeight + 8, bottom: 100),
          itemBuilder: (context, index, animation) {
            if (index > places.length - 1) {
              return const SizedBox.shrink();
            }
            final place = places[index];
            final itemKey = ValueKey(place.id);
            return LocationListItem(
              key: itemKey,
              location: places[index],
              isActive: place.id == state.activePlaceId,
              animation: animation,
              onPress: () => _onPressed(place.id, state.activePlaceId),
              onLongPress: () => _onLongPressed(place.id),
              onDismissed: (_) => _onDismissed(place.id),
              onConfirmDismiss:
                  (DismissDirection dismissDirection) => _onConfirmDismiss(
                    dismissDirection: dismissDirection,
                    place: place,
                  ),
            );
          },
        );
      },
    );
  }

  void _onPressed(String id, String activeId) {
    unawaited(HapticFeedback.heavyImpact());
    if (id == activeId) {
      GoRouter.of(context).go(Routes.location(activeId));
    } else {
      final cubit = context.read<LocationsListCubit>();
      cubit.onPressed(id: id);
    }
  }

  void _onLongPressed(String id) {
    final cubit = context.read<LocationsListCubit>();
    cubit.onLongPressEdit(id: id);
  }

  Future<void> _onDismissed(String id) async {
    final cubit = context.read<LocationsListCubit>();
    await cubit.onDeleteLocation(id: id);
  }

  Future<bool> _onConfirmDismiss({
    required DismissDirection dismissDirection,
    required PlaceEntity place,
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
