enum ApiPath {
  key,
  getMovie,
  getMovieDetail;

  String get path {
    switch (this) {
      case ApiPath.key:
        return 'apikey';
      case ApiPath.getMovie:
        return 's';
      case ApiPath.getMovieDetail:
        return 'i';
      default:
        return '404';
    }
  }
}

class ApiConstant {
  static const String apiUrl = 'http://www.omdbapi.com/';
  static const String key = '';
}
