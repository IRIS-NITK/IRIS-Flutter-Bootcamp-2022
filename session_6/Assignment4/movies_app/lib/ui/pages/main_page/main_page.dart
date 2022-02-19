import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/navbar_cubit.dart';
import 'package:movies_app/ui/pages/home_page/widgets.dart';
import 'package:movies_app/ui/pages/movie_page/widgets.dart';
import 'package:movies_app/ui/global_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(BlocProvider.of<NavbarCubit>(context).state[2]),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BlocProvider.of<NavbarCubit>(context).state[1],
      bottomNavigationBar: BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            label:'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            label:'TV Shows',
          ),
          
        ],
        currentIndex: BlocProvider.of<NavbarCubit>(context).state[0],
        onTap: (value) { 
          // Navigator.push(context, route)
          BlocProvider.of<NavbarCubit>(context).navPage(value);
        },
      ),
    );
  }
}