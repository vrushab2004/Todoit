import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glass/glass.dart';
import 'package:provider/provider.dart';
import 'package:todoit/constans/colors.dart';
import 'package:todoit/constans/theme.dart';
import 'package:todoit/model/theme_provider.dart';
import 'package:todoit/model/todo.dart';
import 'package:todoit/todoitem.dart';


class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
final todoList = ToDo.todoList();
final _todoController = TextEditingController();
class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    void _deleteToDoitem(String id){
  setState(() {
      todoList.removeWhere((todo) => todo.id == id);
  });
}
void _addToDoItem(String toDo){
  setState(() {
    todoList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
  });
  _todoController.clear();
  }
  bool isSwitched = Provider.of<ThemeProvider>(context).themeData == darkmode;
    return Stack(
      children:[ Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(top:20, left: 20 ),
            child: Switch(value:isSwitched, onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  },),
          ),
          backgroundColor: Colors.transparent,
          title:Container(
            margin: EdgeInsets.only(left: 5,top: 20),
            child: Animate(
              child: Text('Todoit',style:GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 50),).animate().tint(color:Theme.of(context).colorScheme.primary,)
              
              )),
        ),
        body: 
        
        
        Stack(
  children: [
    todoList.isEmpty
        ? Center(
          child: Column(
            children:[ Container(
              margin: EdgeInsets.only(left: 50,right: 50,top:80),
              child: Image.asset('assets/To do list-rafiki.png',height: 300,),
              ),
              
              Container(
                 child: Text(
                  'No ToDo-items present',
                  style: GoogleFonts.aBeeZee(fontSize: 18,)
                ),
              )
            ]
          ),
        )
        : ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Divider(
                  thickness: 0.3,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              for (ToDo todo in todoList.reversed)
                Todoitem(
                  todo: todo,
                  onToDochanged: _handleToDochange,
                  onDeleteItem: _deleteToDoitem,
                ),
            ],
          ),
    Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: tdtext,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 8,
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                cursorColor: tdpurple,
                style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: tdbackground),
                decoration: InputDecoration(
                  hintText: 'Write Your TODO',
                  hintStyle: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey.shade700),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                _addToDoItem(_todoController.text);
              },
              child: Text(
                '+',
                style: TextStyle(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.surface,
                    fontWeight: FontWeight.w400),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(200),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
)
      )
      ]);
    
  }
  void _handleToDochange(ToDo todo){
setState((){
todo.isDone = !todo.isDone;
});
  }
}



