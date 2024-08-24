import 'package:flutter/material.dart';
import 'package:music/theme/dark_mode.dart';
import 'package:music/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  //initially light mode 

  ThemeData _themedata = lightmode;


  //get theme 
  ThemeData get themedata => _themedata;

  //is dark mode 
  bool get isDarkMode => _themedata == darkmode;

  // setting theme 
  set themedata (ThemeData themedata){
    _themedata = themedata;
  }
 notifyListeners() ;

 void toogletheme(){
  if (_themedata == lightmode) {
    themedata = darkmode;
  }else{
    themedata = lightmode;
  }
 }
}