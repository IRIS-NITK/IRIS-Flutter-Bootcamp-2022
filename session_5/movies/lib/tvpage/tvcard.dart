import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/movie_bloc.dart';
import 'package:movies/tvpage/tv.dart';
import 'tv.dart';
import 'package:movies/tvpage/tv_detail.dart';

class TVCard extends StatefulWidget {
  final TV movie;
  const TVCard({Key? key, required this.movie}) : super(key: key);

  @override
  _TVCardState createState() => _TVCardState();
}

class _TVCardState extends State<TVCard> {
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
            openBuilder: (context, _) => TVDetailPage(movie: widget.movie),
          );
        });
  }
}
