import 'package:equatable/equatable.dart';
import 'package:susanin/domain/compass/entities/compass.dart';
import 'package:susanin/domain/location/entities/position.dart';

class MainPointerState extends Equatable {
  final bool isLoading;
  final PositionEntity position;
  final CompassEntity compass;
  final bool isServiceEnabled;
  final bool isPermissionGranted;
  final bool isCompassError;
  final bool isUnknownError;
  // ! TODO поля не entities а нужные для UI - угол и расстояние.

  const MainPointerState({
    required this.isLoading,
    required this.position,
    required this.compass,
    required this.isServiceEnabled,
    required this.isPermissionGranted,
    required this.isCompassError,
    required this.isUnknownError,
  });

  @override
  List<Object> get props => [
        isLoading,
        position,
        compass,
        isServiceEnabled,
        isPermissionGranted,
        isCompassError,
        isUnknownError,
      ];

  MainPointerState copyWith({
    bool? isLoading,
    PositionEntity? position,
    CompassEntity? compass,
    bool? isServiceEnabled,
    bool? isPermissionGranted,
    bool? isCompassError,
    bool? isUnknownError,
  }) {
    return MainPointerState(
      isLoading: isLoading ?? this.isLoading,
      position: position ?? this.position,
      compass: compass ?? this.compass,
      isServiceEnabled: isServiceEnabled ?? this.isServiceEnabled,
      isPermissionGranted: isPermissionGranted ?? this.isPermissionGranted,
      isCompassError: isCompassError ?? this.isCompassError,
      isUnknownError: isUnknownError ?? this.isUnknownError,
    );
  }
}

// class MainPointerNoCompass extends MainPointerState {
//   const MainPointerNoCompass({
//     required PositionEntity position,
//     required CompassEntity compass,
//   }) : super(
//           position: position,
//           compass: compass,
//         );
// }

// class MainPointerLoading extends MainPointerState {
//   const MainPointerLoading({
//     required PositionEntity position,
//     required CompassEntity compass,
//   }) : super(
//           position: position,
//           compass: compass,
//         );
// }

// class MainPointerInit extends MainPointerState {
//   const MainPointerInit({
//     required PositionEntity position,
//     required CompassEntity compass,
//   }) : super(
//           position: position,
//           compass: compass,
//         );
// }

// class MainPointerLoaded extends MainPointerState {
//   const MainPointerLoaded({
//     required PositionEntity position,
//     required CompassEntity compass,
//   }) : super(
//           position: position,
//           compass: compass,
//         );
// }

// class MainPointerError extends MainPointerState {
//   final bool isServiceEnabled;
//   final bool isPermissionGranted;
//   final bool isCompassError;
//   final bool isUnknownError;

//   const MainPointerError({
//     required this.isServiceEnabled,
//     required this.isPermissionGranted,
//     required this.isCompassError,
//     required this.isUnknownError,
//     required PositionEntity position,
//     required CompassEntity compass,
//   }) : super(
//           position: position,
//           compass: compass,
//         );

//   @override
//   List<Object> get props => [
//         isServiceEnabled,
//         isPermissionGranted,
//         isCompassError,
//         isUnknownError,
//       ];
// }
