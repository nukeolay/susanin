import 'package:equatable/equatable.dart';

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

class MainPointerLoaded extends MainPointerState {
  final double pointerAngle;

  const MainPointerLoaded(this.pointerAngle);

  @override
  List<Object> get props => [pointerAngle];
}

class MainPointerError extends MainPointerState {
  final String message;

  const MainPointerError(this.message);

  @override
  List<Object> get props => [message];
}
