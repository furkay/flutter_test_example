part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {
  const MovieEvent();
}

class MovieInit extends MovieEvent {}

class MovieSearch extends MovieEvent {
  final String searchText;

  const MovieSearch(this.searchText);
}
