import 'screen_bloc.dart';
import 'package:flutter/material.dart';

import 'widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  final searching = SearchBloc();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var titlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: titlecontroller,
            style: TextStyle(color: Colors.white),
            onFieldSubmitted: (value) {
              widget.searching.searchsink.add(value);
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
              color: Colors.white,
              onPressed: titlecontroller.clear,
              icon: Icon(Icons.clear),
            )),
          ),
        ),
        body: widget.searching.screenstream != null
            ? StreamBuilder(
                stream: widget.searching.screenstream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Some error occurred. Please try again"),
                    );
                  } else if (snapshot.hasData) {
                    final movies = snapshot.data as List;
                    if (movies != []) {
                      return ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, i) => DataTile(
                          title: movies[i]["title"],
                          image: movies[i]["image"],
                          id: movies[i]["id"],
                        ),
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text("no movies found"));
                },
              )
            : const Center(child: Text("no movies found")));
  }
}
