abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'An error occurred on the server.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure(
      [super.message = 'No internet connection. Please try again.']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred.']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'An unexpected error occurred.']);
}
