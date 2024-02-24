import 'package:equatable/equatable.dart';

abstract class UseCase<T, V extends Params> {
  const UseCase();
  T call(V params);
}

abstract class Params extends Equatable {
  const Params();
}

class NoParams extends Params {
  const NoParams();
  
  @override
  List<Object?> get props => [];
}
