import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/movie_models/movie.dart';

class MovieWidget extends StatefulWidget {
  const MovieWidget({Key? key, required this.movies}) : super(key: key);

  final List<Movie> movies;

  @override
  _MovieWidgetState createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.movies.length,
        itemBuilder: (context, i){
          return ListTile(
            leading: Image.network(
                widget.movies[i].image,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            title: Text(
                widget.movies[i].title
            ),
            subtitle: Text(
                widget.movies[i].year
            ),
            trailing: Text(
              widget.movies[i].rating
            ),
            onTap: (){
              BlocProvider.of<MovieBloc>(context).add(
                  CastofMovie(widget.movies[i])
              );
            },
          );
        }
    );
  }
}
