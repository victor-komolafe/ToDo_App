import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List<dynamic> ToDoList = [];

  List<bool> storeValues = [];

  // List<Map<String,bool> ToDoList = [];
  final _myBox = Hive.box("mybox"); //referencing the Box
  final _myStore = Hive.box("myStore");

  void saveShowStatus() async {
    await _myStore.put('stores', true);
  }

  void stopShowStaus() async {
    //flag for todoTile tutorials
    await _myStore.put('stores', false);
  }

  Future<bool?> getShowStatus() async {
    //flag for HomePage tutorials
    final value = await Hive.box("myStore");

    if (value.containsKey('stores')) {
      bool? getData = value.get('stores');
      return getData;
    } else {
      return false;
    }
  }

  Future<bool?> endTutorial() async {
    final value = await Hive.box("myStore");

    if (value.containsKey('EndTutorial')) {
      bool? getData = value.get('EndTutorial');
      return getData;
    } else {
      return false;
    }
  }

  //method to load initial data which runs only when app is first run
  void createInitialData() {
    ToDoList = [
      [
        'Read a book',
        false,
      ],
      // ['Do something', true]
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
