enum ExceptionEnum {
  requestTypeException,
  responseException,
  initMovieException;

  String get message {
    switch (this) {
      case ExceptionEnum.requestTypeException:
        return 'Request Type Not Found!';
      case ExceptionEnum.responseException:
        return 'Api response exception!';
      case ExceptionEnum.initMovieException:
        return 'Init movie exception!';
      default:
        return 'Unknown exception!';
    }
  }
}
