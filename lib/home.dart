import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoit/constans/colors.dart';
import 'package:todoit/constans/theme.dart';
import 'package:todoit/model/theme_provider.dart';
import 'package:todoit/model/todo.dart';
import 'package:todoit/database_helper.dart';
import 'package:todoit/todoitem.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoController = TextEditingController();
  List<ToDo> todoList = [];

  @override
  void initState() {
    super.initState();
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    final data = await DatabaseHelper.instance.getTodoList();
    setState(() {
      todoList = data;
    });
  }

  void _deleteToDoItem(String id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    _refreshTodoList();
  }

  void _addToDoItem(String toDo) async {
    final todo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    );
    await DatabaseHelper.instance.insertTodo(todo);
    _todoController.clear();
    _refreshTodoList();
  }

  void _handleToDoChange(ToDo todo) async {
    todo.isDone = !todo.isDone;
    await DatabaseHelper.instance.updateTodo(todo);
    _refreshTodoList();
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = Provider.of<ThemeProvider>(context).themeData == darkmode;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            leading: Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            title: Container(
              margin: EdgeInsets.only(left: 5, top: 20),
              child: Text(
                'Todoit',
                style: GoogleFonts.aBeeZee(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              todoList.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 50, top: 80),
                            child: Image.asset(
                              'assets/To do list-rafiki.png',
                              height: 300,
                            ),
                          ),
                          Container(
                            child: Text(
                              'No ToDo-items present',
                              style: GoogleFonts.aBeeZee(
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
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
                            onToDochanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
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
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoController,
                          cursorColor: tdpurple,
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: tdbackground,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Write Your TODO',
                            hintStyle: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
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
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.primary,
                          ),
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
          ),
        ),
      ],
    );
  }
}