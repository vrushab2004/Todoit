import 'package:flutter/material.dart';
import 'package:todoit/constans/theme.dart';


class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = darkmode;
  ThemeData get themeData => _themeData;

set themeData(ThemeData themeData){
  _themeData = themeData;
  notifyListeners();
}
void toggleTheme(){
  if(_themeData == darkmode){
    themeData = lightmode;
  } else{
    themeData = darkmode; 
  }
}
}