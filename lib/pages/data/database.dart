import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

//reference our box
  final myBox = Hive.box('mybox');

  //run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Do Exercise', false],
      ['Read a Book', false],
    ];
  }

  void loadData() {
    toDoList = myBox.get('TODOLIST');
  }

// update the database
  void updateDataBase() {
    myBox.put('TODOLIST', toDoList);
  }
}
