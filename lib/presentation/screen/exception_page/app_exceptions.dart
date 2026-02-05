abstract class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, {this.details});
}

class NoInternetException extends AppException {
  NoInternetException() : super("No Internet Connection");
}

class ServerException extends AppException {
  ServerException({String? message})
      : super(message ?? "Something went wrong on the server");
}

class TimeoutExceptionCustom extends AppException {
  TimeoutExceptionCustom()
      : super("Request timed out! Please try again.");
}

class UnknownException extends AppException {
  UnknownException({String? message})
      : super(message ?? "Unexpected error occurred.");
}
