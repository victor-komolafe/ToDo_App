import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/dialog_box.dart';
import 'package:to_do_app/to_do_tile.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  //adding Global keys

  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //calling method for creatinginitialMethod which only runs first time app is run
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();

      if (db.ToDoList.isEmpty) {
        db.deleteStoratge();
      }
    }

    // db.createInitialData();

    super.initState();
  }

  //on changed method
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateData();
  }

  //text controller
  final _controller = TextEditingController();

  //savedNewTask
  void savedNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void editOldTask(int index) {
    setState(() {
      db.ToDoList[index][0] = _controller.text;
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void Function(BuildContext)? _deleteTask(int? index) {
    setState(() {
      if (index != null) {
        db.ToDoList.removeAt(index);
      }
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    //adding a new task
    void createNewTask() {
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              Controller: _controller,
              onSave: savedNewTask,
              onCancel: () => Navigator.of(context).pop(),
            );
          });
    }

//editing a Task
    void Function(BuildContext)? _editTask(int index) {
      setState(() {
        final String existingKey = db.ToDoList[index][0];
        _controller.text = existingKey;
        // db.ToDoList.map((e) => );
      });
      showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              Controller: _controller,
              onSave: () => editOldTask(index),
              onCancel: () => Navigator.of(context).pop(),
            );
          });
    }

    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          elevation: 0,
          title: Text('TODO'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: createNewTask,
        ),
        body: ListView.builder(
          itemCount: db.ToDoList.length,
          itemBuilder: (context, index) => ToDOTile(
              taskName: (db.ToDoList[index])[0],
              taskCompleted: (db.ToDoList[index])[1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (context) => _deleteTask(index),
              editTask: () => _editTask(index)),
          // editTask: (context) => _editTask(index)),
        ));
  }
}
