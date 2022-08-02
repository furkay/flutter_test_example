import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_example/core/base/repository/i_base_repository.dart';
import 'package:flutter_test_example/core/base/repository/i_dio_repository.dart';
import 'package:flutter_test_example/core/exception/exception.dart';
import 'package:flutter_test_example/core/model/movie.dart';
import 'package:flutter_test_example/repository/movie/movie_repository.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late MovieRepository movieRepository;
  late Dio client;
  late DioAdapter dioAdapter;
  setUp(() {
    const baseUrl = 'https://example.com';
    client = Dio(BaseOptions(baseUrl: baseUrl));
    dioAdapter = DioAdapter(dio: client);
    movieRepository = MovieRepository(client);
  });

  tearDown(() {
    client.close();
    movieRepository.close();
  });

  group('Movie Repository Test Group', () {
    test('should create MovieRepository without client', () {
      expect(movieRepository, isA<MovieRepository>());
      expect(movieRepository, isA<IDioRepository>());
      expect(movieRepository, isA<IBaseRepository>());
    });

    test('get Movie', () async {
      const fakeJson =
          '{"Search":[{"Title":"Batman Begins","Year":"2005","imdbID":"tt0372784","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"},{"Title":"Batman v Superman: Dawn of Justice","Year":"2016","imdbID":"tt2975590","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"},{"Title":"The Batman","Year":"2022","imdbID":"tt1877830","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMDdmMTBiNTYtMDIzNi00NGVlLWIzMDYtZTk3MTQ3NGQxZGEwXkEyXkFqcGdeQXVyMzMwOTU5MDk@._V1_SX300.jpg"},{"Title":"Batman","Year":"1989","imdbID":"tt0096895","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BZTM2NmZlOTEtYTI5NS00N2JjLWJkNzItMmZkNDBlYmQzNDA2XkEyXkFqcGdeQXVyMTAxODYyODI@._V1_SX300.jpg"},{"Title":"Batman Returns","Year":"1992","imdbID":"tt0103776","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BOGZmYzVkMmItM2NiOS00MDI3LWI4ZWQtMTg0YWZkODRkMmViXkEyXkFqcGdeQXVyODY0NzcxNw@@._V1_SX300.jpg"},{"Title":"Batman & Robin","Year":"1997","imdbID":"tt0118688","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMGQ5YTM1NmMtYmIxYy00N2VmLWJhZTYtN2EwYTY3MWFhOTczXkEyXkFqcGdeQXVyNTA2NTI0MTY@._V1_SX300.jpg"},{"Title":"Batman Forever","Year":"1995","imdbID":"tt0112462","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNDdjYmFiYWEtYzBhZS00YTZkLWFlODgtY2I5MDE0NzZmMDljXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"},{"Title":"The Lego Batman Movie","Year":"2017","imdbID":"tt4116284","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BMTcyNTEyOTY0M15BMl5BanBnXkFtZTgwOTAyNzU3MDI@._V1_SX300.jpg"},{"Title":"Batman: The Animated Series","Year":"1992–1995","imdbID":"tt0103359","Type":"series","Poster":"https://m.media-amazon.com/images/M/MV5BOTM3MTRkZjQtYjBkMy00YWE1LTkxOTQtNDQyNGY0YjYzNzAzXkEyXkFqcGdeQXVyOTgwMzk1MTA@._V1_SX300.jpg"},{"Title":"Batman: Under the Red Hood","Year":"2010","imdbID":"tt1569923","Type":"movie","Poster":"https://m.media-amazon.com/images/M/MV5BNmY4ZDZjY2UtOWFiYy00MjhjLThmMjctOTQ2NjYxZGRjYmNlL2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"}],"totalResults":"512","Response":"True"}';

      dioAdapter.onGet('', (server) => server.reply(200, jsonDecode(fakeJson)));

      final result = await movieRepository.searchMovies(searchText: 'Batman');
      expect(result, isA<List<Movie>>());
      expect(result.isNotEmpty, true);
    });

    test('get Movie response false', () async {
      const fakeJson = '{"Response" : "False","Error": "Incorrect IMDb ID."}';

      dioAdapter.onGet('', (server) => server.reply(200, jsonDecode(fakeJson)));

      final result = await movieRepository.searchMovies(searchText: '');
      expect(result, isA<List<Movie>>());
      expect(result.isEmpty, true);
    });

    test('get Movie exception', () async {
      const fakeJson = '{"Response" : "False","Error": "Incorrect IMDb ID."}';

      dioAdapter.onGet('', (server) => server.reply(400, fakeJson));

      expect(
        () => movieRepository.searchMovies(searchText: ''),
        throwsA(isA<ResponseException>()),
      );
    });
  });
}
