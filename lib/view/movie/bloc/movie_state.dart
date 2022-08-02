part of 'movie_bloc.dart';

@immutable
abstract class MovieState {
  const MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);
}

class MovieLoading extends MovieState {}

class MovieException extends MovieState {
  final Exception exception;

  const MovieException(this.exception);
}
