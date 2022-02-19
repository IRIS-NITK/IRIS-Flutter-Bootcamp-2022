/*
    This File handles the Widgets of the movie page
*/

import 'package:flutter/material.dart';
import 'api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/navbar_cubit.dart';

// AppBar Widget ======================================

AppBar appBar = AppBar(
  title: Text('Top 250 Movies'),
  centerTitle: true,
);

// ====================================================

class Top250 {
  static FutureBuilder popularMovies = FutureBuilder(
    future: getTop250Movies(),
    initialData: List.empty(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasError) {
        return Text(snapshot.error.toString());
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator.adaptive());
      } else {
        return Column(
          children: [
            Divider(
              thickness: 5,
            ),
            Text(
              'Top 250 Movies',
              style: TextStyle(fontSize: 25),
            ),
            Divider(
              thickness: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var popularMovies = snapshot.data;
                  return Card(
                      child: ListTile(
                    leading: Image.network(popularMovies[index]["image"]),
                    title:
                        Text("${index + 1}.  ${popularMovies[index]["title"]}"),
                    tileColor: Colors.blue.shade100,
                  ));
                },
              ),
            ),
          ],
        );
      }
    },
  );

// ====================================================

  // static FutureBuilder search(String expression){
  static var search = BlocProvider(
    create: (context) => NavbarCubit(),
    child: BlocBuilder<NavbarCubit, List>(
      builder: (context, state) {
        return FutureBuilder(
          future: searchMovies(BlocProvider.of<NavbarCubit>(context).state[3]),
          initialData: List.empty(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              print(_search.text);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var popularMovies = snapshot.data;
                        return Card(
                            child: ListTile(
                          leading: Image.network(popularMovies[index]["image"]),
                          title: Text(
                              "${index + 1}.  ${popularMovies[index]["title"]}"),
                          tileColor: Colors.blue.shade100,
                        ));
                      },
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    ),
  );

  //     return search;
  // }

  static TextEditingController _search = TextEditingController();

  static Widget movie = BlocProvider(
    create: (context) => NavbarCubit(),
    child: BlocBuilder<NavbarCubit, List>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                trailing: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    BlocProvider.of<NavbarCubit>(context).search(_search.text);
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    labelText: 'Search for a movie',
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(child: _search.text.isEmpty?Text(''):search),
              Text(_search.text),
              Expanded(child: popularMovies),
            ],
          ),
        );
      },
    ),
  );
}
