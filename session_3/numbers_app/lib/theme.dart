

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  

  ThemeData light = ThemeData.light();
  ThemeData dark = ThemeData.dark();
  ThemeData _selectedTheme = ThemeData.dark();

  ThemeProvider({required bool isDarkMode}){
    _selectedTheme = isDarkMode?dark:light;
  }

  void swapTheme() {
    _selectedTheme = _selectedTheme == dark? light : dark ;
    notifyListeners();
  }

  ThemeData get getTheme =>_selectedTheme;

  
}