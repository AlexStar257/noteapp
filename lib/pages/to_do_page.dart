import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noteapp/pages/data/database.dart';
import 'package:noteapp/pages/util/dialog_box.dart';
import 'package:noteapp/pages/todo_tile.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final mybox = Hive.box('mybox');
  final controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //If this is the first time
    if (mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      //There already exists data
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: saveTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        shadowColor: Colors.black,
        elevation: 2,
        title: const Center(
          child: Text(
            'TO DO',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: createTask,
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0, color: Colors.yellow),
              borderRadius: BorderRadius.circular(100)),
          splashColor: Colors.yellow[200],
          child: const Icon(Icons.add),
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
