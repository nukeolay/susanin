import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susanin/core/extensions/extensions.dart';
import 'package:susanin/features/places/domain/entities/place_entity.dart';
import 'package:susanin/presentation/common/widgets/susanin_button.dart';
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

  Future<void> _onDismissed(
    LocationsListCubit cubit,
    int index,
    String id,
  ) async {
    await cubit.onDeleteLocation(id: id);
    animatedListKey.currentState!.removeItem(
      index,
      (_, __) => Container(),
    );
  }

  Future<bool> _onConfirmDismiss({
    required DismissDirection dismissDirection,
    required int index,
    required PlaceEntity place,
    required bool isActive,
  }) async {
    if (dismissDirection == DismissDirection.startToEnd) {
      HapticFeedback.heavyImpact();
      return _showRemoveConfirmationDialog(context: context);
    } else {
      HapticFeedback.heavyImpact();
      context.read<LocationsListCubit>().onShare(place);
      return false;
    }
  }
}

Future<bool> _showRemoveConfirmationDialog({
  required BuildContext context,
}) async {
  final result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.s.delete_location,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: SusaninButton(
                                type: ButtonType.secondary,
                                label: context.s.button_no,
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SusaninButton(
                                type: ButtonType.primary,
                                label: context.s.button_yes,
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ) ??
      false;
  return result;
}