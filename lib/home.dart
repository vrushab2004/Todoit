import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass/glass.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 15, 14),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:Container(
            margin: EdgeInsets.only(left: 20,top: 10),
            child: Animate(
              child: Text('Todoit',style:GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50),).animate().tint(color:const Color.fromARGB(255, 200, 153, 209))
              
              )),
        ),
        body: Container(
          child: TextField(),
        ).asGlass(tintColor: Colors.transparent),
        floatingActionButton:  Padding(
          padding: const EdgeInsets.only(bottom:20 ),
          child: FloatingActionButton(onPressed: (){
            
          },
          backgroundColor:const Color.fromARGB(255, 200, 153, 209) ,
          elevation: 30,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: 
          Icon(Icons.add,size: 38,color: Colors.black,),),
        ),
        
      ),
      ]
    );
  }
}