// import 'package:bloc/bloc.dart';
// import 'package:bloc_imdb_movies_app/models/MovieData.dart';
// import 'package:bloc_imdb_movies_app/models/TVShowData.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc_imdb_movies_app/repository/MovieDataRepo.dart';
// import 'package:bloc_imdb_movies_app/repository/TVShowDataRepo.dart';

class MoviesEvent {}

class SearchEvent extends MoviesEvent {
  String query;
  SearchEvent(this.query);
}

class MoviesState{}
class ShowsDisplayingErrorState {}
class ShowsNotSearchedState extends MoviesState {}
class ShowsLoadingState extends MoviesState {}
class ShowsLoadedState extends MoviesState {}
class ShowsLoadingErrorState extends MoviesState {}

