import 'package:flutter/material.dart';


ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 233, 233, 233),
    primary: Color.fromARGB(255, 197, 8, 250),
    secondary: Color.fromARGB(255, 58, 58, 58)
  )
);
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 17, 15, 14),
    primary: Color.fromARGB(255, 200, 153, 209),
    secondary: Color.fromARGB(255, 206, 206, 206)
  )
);