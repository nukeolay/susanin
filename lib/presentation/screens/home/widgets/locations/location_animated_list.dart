// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:susanin/domain/location_points/entities/location_point.dart';
// import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_cubit.dart';
// import 'package:susanin/presentation/bloc/locations_list_cubit/locations_list_state.dart';
// import 'package:susanin/presentation/screens/home/widgets/common/location_bottom_sheet.dart';
// import 'package:susanin/presentation/screens/home/widgets/locations/location_list_item.dart';

// class LocationAnimatedList extends StatefulWidget {
//   final double topPadding;
//   const LocationAnimatedList({required this.topPadding, Key? key})
//       : super(key: key);

//   @override
//   State<LocationAnimatedList> createState() => _LocationAnimatedListState();
// }

// class _LocationAnimatedListState extends State<LocationAnimatedList> {
//   final animatedListKey = GlobalKey<AnimatedListState>();
//   late int len;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocConsumer<LocationsListCubit, LocationsListState>(
//         listener: ((context, state) {
//           if (state.status == LocationsListStatus.editing) {
//             _showBottomSheet(context, state as EditLocationState);
//           } else if (state.status == LocationsListStatus.failure) {
//             final snackBar = SnackBar(
//               content: Text('unknown_error'.tr()),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           } else if (state.locations.length > len) {
//             animatedListKey.currentState!.insertItem(0);
//           }
//         }),
//         builder: ((context, state) {
//           len = state.locations.length;
//           if (state.status == LocationsListStatus.loading) {
//             return const SingleChildScrollView(
//                 child: CircularProgressIndicator());
//           } else if (state.locations.isEmpty) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'empty_locations_list'.tr(),
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 30),
//                 ),
//               ),
//             );
//           } else {
//             final locations = state.locations;
//             return AnimatedList(
//               key: animatedListKey,
//               physics: const BouncingScrollPhysics(),
//               shrinkWrap: true,
//               initialItemCount: locations.length,
//               padding: EdgeInsets.only(top: widget.topPadding, bottom: 100),
//               itemBuilder: (context, index, animation) {
//                 final invertedIndex = locations.length - index - 1;
//                 final location = locations[invertedIndex];
//                 final itemKey = ValueKey(location.name);
//                 return LocationListItem(
//                   key: itemKey,
//                   location: locations[invertedIndex],
//                   isActive: location.id == state.activeLocationId,
//                   animation: animation,
//                   onPress: () {
//                     HapticFeedback.heavyImpact();
//                     context
//                         .read<LocationsListCubit>()
//                         .onPressSetActive(id: location.id);
//                   },
//                   onLongPress: () => context
//                       .read<LocationsListCubit>()
//                       .onLongPressEdit(id: location.id),
//                   onDismissed: (value) async {
//                     await context
//                         .read<LocationsListCubit>()
//                         .onDeleteLocation(id: location.id);
//                   },
//                   onConfirmDismiss: (DismissDirection dismissDirection) async {
//                     if (dismissDirection == DismissDirection.startToEnd) {
//                       HapticFeedback.heavyImpact();
//                       return _showConfirmationDialog(
//                         context: context,
//                         globalKey: animatedListKey,
//                         index: invertedIndex,
//                         animation: animation,
//                         isActive: location.id == state.activeLocationId,
//                         location: location,
//                       );
//                     } else {
//                       HapticFeedback.heavyImpact();
//                       await Share.share(
//                           '${location.name} https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}');
//                       return false;
//                     }
//                   },
//                 );
//               },
//             );
//           }
//         }),
//       ),
//     );
//   }

//   void _showBottomSheet(BuildContext context, EditLocationState state) async {
//     await showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return LocationBottomSheet(
//           name: state.name,
//           latitude: state.latitude.toString(),
//           longitude: state.longitude.toString(),
//           saveLocation: (
//             String latitude,
//             String longitude,
//             String name,
//           ) async {
//             await context.read<LocationsListCubit>().onSaveLocation(
//                   latitude: double.parse(latitude),
//                   longitude: double.parse(longitude),
//                   newLocationName: name,
//                   id: state.id,
//                 );
//           },
//         );
//       },
//     );
//     context.read<LocationsListCubit>().onBottomSheetClose();
//   }
// }

// Future<bool?> _showConfirmationDialog({
//   required BuildContext context,
//   required GlobalKey<AnimatedListState> globalKey,
//   required int index,
//   required LocationPointEntity location,
//   required bool isActive,
//   required Animation<double> animation,
// }) async {
//   return showDialog<bool>(
//     context: context,
//     barrierDismissible: true,
//     builder: (BuildContext context) {
//       return CupertinoAlertDialog(
//         title: Text('delete_location'.tr()),
//         actions: [
//           CupertinoDialogAction(
//             child: Text('button_yes'.tr()),
//             onPressed: () {
//               globalKey.currentState!.removeItem( // ! TODO
//                   index,
//                   (context, animation) => LocationListItem(
//                         location: location,
//                         isActive: isActive,
//                         animation: animation,
//                         onPress: null,
//                         onLongPress: null,
//                         onDismissed: null,
//                         onConfirmDismiss: null,
//                       ));
//               Navigator.pop(context, true);
//             },
//           ),
//           CupertinoDialogAction(
//             child: Text('button_no'.tr()),
//             onPressed: () {
//               Navigator.pop(context, false);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
