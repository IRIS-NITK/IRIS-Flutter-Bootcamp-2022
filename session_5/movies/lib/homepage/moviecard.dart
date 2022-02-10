import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/bloc/movie_bloc.dart';
import 'movie.dart';
import 'package:movies/homepage/movie_detail.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        listener: (context, state) {},
        builder: (context, state) {
          return OpenContainer(
            closedElevation: 0,
            closedColor: (!state) ? Colors.white : Colors.black,
            closedBuilder: (context, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.movie.image),
                          fit: BoxFit.contain)),
                  width: 120,
                  height: 170,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.movie.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: (state) ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            openBuilder: (context, _) => MovieDetailPage(movie: widget.movie),
          );
        });
  }
}
