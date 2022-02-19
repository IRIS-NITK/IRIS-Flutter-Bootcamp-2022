import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/cubit/navbar_cubit.dart';
import 'package:movies_app/ui/pages/main_page/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(),
      child: BlocBuilder<NavbarCubit, List>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Material App',
            home: MainPage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
    
    
    
     
  }
}