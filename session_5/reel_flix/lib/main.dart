import 'package:flutter/material.dart';
import 'package:movies/bloc/movie_bloc.dart';
import 'package:movies/homepage/homescreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}

void initialization(BuildContext context) async {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
        BlocProvider<MovieCubit>(create: (_) => MovieCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<PageCubit>(create: (_) => PageCubit()),
        BlocProvider<TVCubit>(create: (_) => TVCubit())
      ],
      child: BlocConsumer<ThemeCubit, bool>(
          listener: (context, value) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: (state)
                  ? ThemeData(
                      scaffoldBackgroundColor: Colors.black,
                      cardColor: Colors.black)
                  : ThemeData(backgroundColor: Colors.white),
              home: const MyHomePage(),
            );
          }),
    );
  }
}
