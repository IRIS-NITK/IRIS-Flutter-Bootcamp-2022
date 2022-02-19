
import 'package:flutter/material.dart';
import 'package:movie_application/controllers/search_list_disp_controller.dart';
import 'package:movie_application/screens/movies_listDisp.dart';
import 'package:movie_application/screens/tvshows_listDisp.dart';
import 'package:get/get.dart';
import 'package:movie_application/screens/watchlist_listDisp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool darkMode = true;

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController();
  final SearchListDispController searchListDispController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies and TV Shows",
          style: TextStyle(fontFamily: "Dongle",fontSize: 40.0),),
          centerTitle: false,
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
          actions: [
            InkWell(
              onTap: () {
                darkMode = true;
                Get.changeThemeMode(ThemeMode.dark);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: const Icon(Icons.dark_mode),
              ),
            ),
            InkWell(
              onTap: () {
                darkMode = false;
                Get.changeThemeMode(ThemeMode.light);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: const Icon(Icons.light_mode),
              ),
            ),
            InkWell(
              onTap: () {
                searchListDispController.onPressSearch(context);
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: const Icon(Icons.search)),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Movies",icon: Icon(Icons.movie),),
              Tab(text: "TV Shows",icon: Icon(Icons.tv),),
              Tab(
                text: "Your Watchlist",icon: Icon(Icons.watch_later)
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          MoviesListDisp(),
          TVShowsListDisp(),
          WatchListDispScreen(),
        ]));
  }
}
