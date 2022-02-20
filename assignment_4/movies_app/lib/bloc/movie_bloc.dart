import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movies_app/movie_models/movie.dart';
import 'package:movies_app/movie_models/api_caller.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(Fetching()) {
    on<MovieEvent>((event, emit) async{

      emit(Fetching());
      final ApiCaller apiCaller = ApiCaller("API_PLACEHOLDER");

      try{
        if(event is Top250Movies || event is SearchMovies) {
          List<Movie> movies = [];

          if (event is Top250Movies) {
            movies = await apiCaller.getTop250Movies(
                "https://imdb-api.com/en/API/Top250Movies"
            );
          }
          else if(event is SearchMovies){
            movies = await apiCaller.searchMovies(
                "https://imdb-api.com/en/API/SearchMovie",
                event.searchitem
            );
          }

          emit(MoviesFetched(movies: movies));

        }
        else if(event is Top250TVs || event is SearchTVs){
          List<TVShow> shows= [];

          if(event is Top250TVs) {
            shows = await apiCaller.getTop250TVs(
                "https://imdb-api.com/en/API/Top250TVs"
            );
          }
          else if(event is SearchTVs){
            shows = await apiCaller.searchTVshows(
                "https://imdb-api.com/en/API/SearchSeries",
                event.searchitem
            );

          }

          emit(TVShowsFetched(shows: shows));

        }
        else if(event is CastofMovie){
          MovieCast cast;

          cast = await apiCaller.getMovieCast(
              "https://imdb-api.com/en/API/FullCast",
              event.movie
          );

          emit(MovieCastFetched(moviecast: cast));

        }
        else if(event is CastofTVShow){
          ShowCast cast;

          cast = await apiCaller.getTVCast(
              "https://imdb-api.com/en/API/FullCast",
              event.show
          );

          emit(TVShowCastFetched(showcast: cast));
        }
        else if(event is Reload){
          emit(Reloaded());
        }
      }
      catch(e){
          emit(MoviesError());
      }

    });
  }
}
