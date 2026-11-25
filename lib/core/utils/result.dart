import '../error/failures.dart';

/// Either a value or a [Failure]. Returned by repositories and use cases.
sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    final self = this;
    return switch (self) {
      Success<T>() => success(self.data),
      Error<T>() => failure(self.failure),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.data);
  final T data;
}

final class Error<T> extends Result<T> {
  const Error(this.failure);
  final Failure failure;
}

/// Runs [body] and converts any thrown exception into an [Error].
Future<Result<T>> guard<T>(Future<T> Function() body) async {
  try {
    return Success(await body());
  } catch (e) {
    return Error(mapExceptionToFailure(e));
  }
}
