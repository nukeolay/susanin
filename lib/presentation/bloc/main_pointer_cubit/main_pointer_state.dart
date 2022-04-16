import 'package:equatable/equatable.dart';
import 'package:susanin/domain/location/entities/position.dart';

abstract class MainPointerState extends Equatable {
  const MainPointerState();

  @override
  List<Object> get props => [];
}

class MainPointerNoCompass extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerLoading extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerInit extends MainPointerState {
  @override
  List<Object> get props => [];
}

class MainPointerLoaded extends MainPointerState {
  final PositionEntity position;

  const MainPointerLoaded(this.position);

  @override
  List<Object> get props => [position];
}

class MainPointerError extends MainPointerState {
  final String message;

  const MainPointerError({required this.message});

  @override
  List<Object> get props => [message];
}
