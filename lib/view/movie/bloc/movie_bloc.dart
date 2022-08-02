import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_example/core/constant/exception/exception_enum.dart';
import 'package:flutter_test_example/repository/movie/movie_repository.dart';

import '../../../core/exception/exception.dart';
import '../../../core/model/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  late MovieRepository _movieRepository;
  MovieBloc(final MovieRepository movieRepository) : super(MovieInitial()) {
    _movieRepository = movieRepository;
    on<MovieInit>(_init);
    on<MovieSearch>(_search);
  }

  Future<void> _init(MovieInit event, Emitter<MovieState> emit) async {
    await _searchMovie(emit);
  }

  Future<void> _search(MovieSearch event, Emitter<MovieState> emit) async {
    await _searchMovie(emit, searchText: event.searchText);
  }

  Future<void> _searchMovie(Emitter<MovieState> emit,
      {String? searchText}) async {
    emit(MovieLoading());
    try {
      final List<Movie> movies = await _movieRepository.searchMovies(
        searchText: searchText ?? '',
      );
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(
        MovieException(
          InitMovieException(ExceptionEnum.initMovieException.message),
        ),
      );
    }
  }
}
