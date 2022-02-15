import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/movie_bloc.dart';
import 'package:movies_app/movie_models/movie.dart';

class TVShowWidget extends StatefulWidget {
  const TVShowWidget({Key? key, required this.shows}) : super(key: key);

  final List<TVShow> shows;

  @override
  _TVShowWidgetState createState() => _TVShowWidgetState();
}

class _TVShowWidgetState extends State<TVShowWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.shows.length,
        itemBuilder: (context, i){
          return ListTile(
            leading: Image.network(
              widget.shows[i].image,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            ),
            title: Text(
                widget.shows[i].title
            ),
            subtitle: Text(
                "${widget.shows[i].year}  ${
                    widget.shows[i].crew.toString().isNotEmpty ?
                      "Featuring ${
                        (widget.shows[i].crew.toString().length > 18) ?
                          widget.shows[i].crew.toString().substring(0, 18) + "..." :
                          widget.shows[i].crew.toString()
                      }"
                      : ""
                }"
            ),
            trailing: Text(
                widget.shows[i].rating
            ),
            onTap: (){
              BlocProvider.of<MovieBloc>(context).add(
                  CastofTVShow(widget.shows[i])
              );
            },
          );
        }
    );
  }
}
