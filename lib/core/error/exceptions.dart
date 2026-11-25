/// Thrown by data sources; converted to a [Failure] in repositories.
class ServerException implements Exception {
  const ServerException(this.message, {this.statusCode});
  final String message;
  final int? statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements Exception {
  const NetworkException([this.message = 'No internet connection']);
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}

class NotFoundException implements Exception {
  const NotFoundException([this.message = 'Not found']);
  final String message;
}
