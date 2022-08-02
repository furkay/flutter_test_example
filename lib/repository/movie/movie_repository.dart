import 'package:flutter_test_example/core/base/repository/i_dio_repository.dart';
import 'package:flutter_test_example/core/constant/api/api_enum.dart';
import 'package:flutter_test_example/core/constant/exception/exception_enum.dart';
import 'package:flutter_test_example/core/constant/request/request_enum.dart';

import '../../core/exception/exception.dart';
import '../../core/model/movie.dart';

class MovieRepository extends IDioRepository {
  MovieRepository(super.client);

  Future<List<Movie>> searchMovies({String searchText = ''}) async {
    try {
      final response = await request(
        requestType: RequestType.get,
        path: '',
        queryParameters: {
          ApiPath.getMovie.path: searchText,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;

        if (data['Response'] == 'True') {
          final result = List<Map<String, dynamic>>.from(data['Search']);
          return result.map((e) => Movie.fromMap(e)).toList();
        }

        if (data['Response'] == 'False') {
          return [];
        }
        return throw ResponseException(ExceptionEnum.responseException.message);
      }
      return throw RequestTypeException(
          ExceptionEnum.responseException.message);
    } catch (e) {
      return throw ResponseException(ExceptionEnum.responseException.message);
    }
  }
}
