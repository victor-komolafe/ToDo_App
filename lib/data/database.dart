import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List<dynamic> ToDoList = [];
  // List<Map<String,bool> ToDoList = [];
  final _myBox = Hive.box("mybox"); //referencing the Box

  //method to losd initial data which runs only when app is first run
  void createInitialData() {
    ToDoList = [
      ['Read a book', false],
      ['Do something', true]
    ];
  }

  //load Data from Db
  void loadData() {
    // ToDoList = _myBox.keys.map((e) => e).toList();

    // print(_myBox.get("TODOLIST").runtimeType);
    ToDoList = _myBox.get("TODOLIST");
  }

  //update Data
  void updateData() async {
    await _myBox.put('TODOLIST', ToDoList);
  }

  void deleteStoratge() async {
    await _myBox.delete("TODOLIST");
  }
}
