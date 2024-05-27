import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoit/constans/colors.dart';
import 'package:todoit/model/todo.dart';


class Todoitem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDochanged;
  final Function(String) onDeleteItem;
const Todoitem ({Key? key, required this.todo,required this.onToDochanged,required this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      
      background: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 12),
        color: Colors.red,
        // padding: EdgeInsets.only(left: 20),
        // alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(left: 300),
          child: Icon(Icons.delete, color: Colors.white,size: 30,)),
      ),
      key: Key(todo.id!),
      onDismissed: ( direction) {
        onDeleteItem(todo.id!);
      },
    
    child :Column(
      children: [
        Container(
          child: ListTile(
            onTap: (){
              onToDochanged(todo);
            },
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),
            tileColor: Colors.transparent,
            leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank,color: Theme.of(context).colorScheme.primary,),
            title: Text(todo.todoText!,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 22,color:Theme.of(context).colorScheme.secondary,decoration:todo.isDone? TextDecoration.lineThrough : null,decorationColor: Colors.white),),
          ),
        ),
        Container(
              margin: EdgeInsets.only(top: 0),
              child: Divider(
                thickness: 0.3,
                color: Theme.of(context).colorScheme.secondary,
                ),
            ),
      ],
    )
    );
  }
}