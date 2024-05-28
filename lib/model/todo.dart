import 'package:isar/isar.dart';


class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  // Constructor with proper syntax
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  // Static method to return a list of ToDo objects
  static List<ToDo> todoList() {
    return [


    ];
  }
}
