class RequestTypeException implements Exception {
  final dynamic message;

  RequestTypeException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "RequestTypeException";
    return "RequestTypeException: $message";
  }
}

class ResponseException implements Exception {
  final dynamic message;

  ResponseException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "ResponseException";
    return "ResponseException: $message";
  }
}

class InitMovieException implements Exception {
  final dynamic message;

  InitMovieException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "InitMovieException";
    return "InitMovieException: $message";
  }
}
