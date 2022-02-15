part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent {}

class Top250Movies extends MovieEvent{
  Top250Movies();
}
class Reload extends MovieEvent{
  Reload();
}

class Top250TVs extends MovieEvent{
  Top250TVs();
}

class SearchMovies extends MovieEvent{
  SearchMovies(this.searchitem);

  final String searchitem;
}

class SearchTVs extends MovieEvent{
  SearchTVs(this.searchitem);

  final String searchitem;
}

class CastofMovie extends MovieEvent{
  CastofMovie(this.movie);

  final Movie movie;
}

class CastofTVShow extends MovieEvent{
  CastofTVShow(this.show);

  final TVShow show;
}

