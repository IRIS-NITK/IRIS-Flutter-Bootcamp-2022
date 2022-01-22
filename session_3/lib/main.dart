import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.lato().fontFamily,
        ));
  }
}
