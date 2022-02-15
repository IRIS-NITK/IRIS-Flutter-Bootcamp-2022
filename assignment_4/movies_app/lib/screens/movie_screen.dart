import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/movie_models/movie.dart';
import 'package:movies_app/screens/cast_screen.dart';
import 'package:movies_app/screens/tvshow_screen.dart';
import 'package:movies_app/widgets/movie_widget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  List<Movie> finalMovieList = [];
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MovieBloc>(context).add(Top250Movies());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Top 250 Movies",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                showSearch(
                    context: context,
                    delegate: searchDelegate()
                );
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      drawer: Drawer(
        child: Material(
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.amber,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ),
              Container(
                color: Colors.amber,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: DrawerHeader(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "imDb",
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  ),
                ),
              ),
              const Divider(
                color: Colors.white54,
              ),
              ListTile(
                title: const Center(
                  child: Text(
                    "Movies",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                selected: true,
                onTap: (){
                  selectedItem(context, 0);
                },
              ),
              ListTile(
                title: const Center(
                  child: Text(
                  "TV Series",
                    style: TextStyle(
                     fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                onTap: (){
                  selectedItem(context, 1);
                },
              )
            ],
          ),
        )
      ),
      body: BlocConsumer<MovieBloc, MovieState>(
        builder: (context, state){
          if(state is Fetching){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is MoviesFetched){
            finalMovieList = state.movies;
            return MovieWidget(
                movies: state.movies
            );
          }
          else if(state is Reloaded){
            return MovieWidget(
                movies: finalMovieList
            );
          }
          else if(state is MovieCastFetched){
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        BlocProvider.of<MovieBloc>(context).add(Reload());
                        return CastScreen(movieCast: state.moviecast);}
                  )
              );
            });
            return Container();
          }
          else
            {
              return Container();
            }
        },
        listener: (context, state){
        },
      ),
    );
  }

  void selectedItem(BuildContext context, int i)
  {
    switch(i)
    {
      case 0:
        Navigator.of(context).pop();
        break;
      case 1:
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) {
                    //BlocProvider.of<MovieBloc>(context).add(Top250TVs());
                    return const TVShowScreen();
                  }
              )
          );
        });
        break;
    }
  }

}

class searchDelegate extends SearchDelegate{
  List<String> searchTerms = [];

  // TODO: search history
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: ()
        {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(
       onPressed: (){
         BlocProvider.of<MovieBloc>(context).add(Top250Movies());
         close(context, null);
       },
       icon: const Icon(Icons.arrow_back)
   );
  }

  @override
  Widget buildResults(BuildContext context) {
     BlocProvider.of<MovieBloc>(context).add(
       SearchMovies(query)
     );

     return WillPopScope(
       onWillPop: () async{

         BlocProvider.of<MovieBloc>(context).add(Top250Movies());
         close(context, null);
         return await Future.delayed(const Duration(milliseconds: 1));
       },
       child: BlocConsumer<MovieBloc, MovieState>(
         builder: (context, state){
           if(state is Fetching){
             return const Center(child: CircularProgressIndicator());
           }
           else if(state is MoviesFetched) {
             List<Movie> movies = state.movies;
             return MovieWidget(movies: movies);
           }

           return const Text("");
         },
         listener: (context, state){
         },
       ),
     );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text(" ");
  }

}
