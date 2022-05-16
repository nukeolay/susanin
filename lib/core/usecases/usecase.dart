abstract class UseCase<OutputType> {
  OutputType call();
}

abstract class UseCaseWithArguments<OutputType, InputType> {
  OutputType call(InputType argument);
}