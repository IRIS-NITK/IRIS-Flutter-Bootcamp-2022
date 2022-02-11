import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/bloc/movie_bloc.dart';
import 'package:movies/search_screen/search_page.dart';
import 'body.dart';
import 'package:movies/tvpage/body2.dart' as TV;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        builder: (context, value) => BlocConsumer<PageCubit, int>(
            listener: (context, state) {},
            builder: (context, index) {
              return Scaffold(
                  appBar: AppBar(
                      elevation: 0,
                      backgroundColor: (value) ? Colors.black : Colors.white,
                      actions: <Widget>[
                        IconButton(
                            onPressed: () {
                              context.read<ThemeCubit>().update(!value);
                            },
                            icon: (!value)
                                ? const Icon(
                                    Icons.wb_sunny_outlined,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.nightlight_outlined,
                                    color: Colors.white,
                                  )),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()));
                          },
                          icon: const Icon(Icons.search),
                          color: (value) ? Colors.white : Colors.black,
                        )
                      ]),
                  body: (index == 1) ? const TV.Body() : const Body(),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: index,
                    onTap: (_) {
                      if (index == 0) {
                        context.read<PageCubit>().update(1);
                      } else {
                        context.read<PageCubit>().update(0);
                      }
                    },
                    backgroundColor: (value) ? Colors.black : Colors.white,
                    unselectedItemColor: (value) ? Colors.white : Colors.black,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    selectedItemColor: (value) ? Colors.orange : Colors.purple,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.theaterMasks,
                              size: 25,
                              color: (value) ? Colors.white : Colors.black),
                          label: "Movie",
                          activeIcon: Icon(
                            FontAwesomeIcons.theaterMasks,
                            size: 25,
                            color: (value) ? Colors.orange : Colors.purple,
                          )),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.tv,
                              size: 30,
                              color: (value) ? Colors.white : Colors.black),
                          label: "TV",
                          activeIcon: Icon(
                            Icons.tv,
                            size: 30,
                            color: (value) ? Colors.orange : Colors.purple,
                          ))
                    ],
                  ));
            }),
        listener: (context, value) {});
  }
}
