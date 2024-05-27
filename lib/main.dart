import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoit/constans/theme.dart';
import 'package:todoit/home.dart';
import 'package:todoit/model/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create:(context)=>ThemeProvider(),
    child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,

      home: Home(),
    );


  }
}
