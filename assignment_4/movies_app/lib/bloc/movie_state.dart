part of 'movie_bloc.dart';

@immutable
abstract class MovieState {}

class Initial extends MovieState{}

class Fetching extends MovieState{
  Fetching();
}

class MoviesFetched extends MovieState{
  final List<Movie> movies;

  MoviesFetched({required this.movies});
}
class Reloaded extends MovieState{

}

class TVShowsFetched extends MovieState{
  final List<TVShow> shows;

  TVShowsFetched({required this.shows});
}

class MovieCastFetched extends MovieState{
  final MovieCast moviecast;

  MovieCastFetched({required this.moviecast});
}

class TVShowCastFetched extends MovieState{
  final ShowCast showcast;

  TVShowCastFetched({required this.showcast});
}

class MoviesError extends MovieState{}
