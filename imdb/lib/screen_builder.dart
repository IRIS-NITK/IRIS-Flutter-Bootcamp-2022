import 'package:flutter/material.dart';
import 'main.dart';
import 'widget.dart';

class ScreenBuilder extends StatefulWidget {
  ScreenBuilder({Key? key, required this.future}) : super(key: key);

  Stream? future;

  @override
  State<ScreenBuilder> createState() => _ScreenBuilderState();
}

class _ScreenBuilderState extends State<ScreenBuilder> {
  late int action;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.future,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Something Went Wrong!!",
              style: TextStyle(fontSize: 20),
            ));
          } else if (snapshot.hasData) {
            List<Movies> movie = snapshot.data;
            return ListView.builder(
                itemCount: movie.length,
                itemBuilder: (context, i) {
                  return DataTile(
                    title: movie[i].Title,
                    imdb: movie[i].Imdb,
                    image: movie[i].Image,
                    id: movie[i].Id,
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
