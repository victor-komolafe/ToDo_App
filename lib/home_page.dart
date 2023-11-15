import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/dialog_box.dart';
import 'package:to_do_app/in_app_tour_target.dart';
import 'package:to_do_app/to_do_tile.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  //adding Global keys
  final welcomeKey = GlobalKey();

  final addTaskKey = GlobalKey();

  //adding TutorialmcoachMArk instance variable
  late TutorialCoachMark tutorialCoachMark;

  //creating an initstate to init the tutorialMark
  //note we will have to do this for every page we want to show the tutorials on
  void _initializeInAppTourTarget() {
    tutorialCoachMark = TutorialCoachMark(
        targets:
            addhomePageTargets(welcomeKey: welcomeKey, addTaskKey: addTaskKey),
        colorShadow: Colors.black,
        hideSkip: false,
        opacityShadow: 0.8,
        onFinish: () {
          print('Completed');
          ToDoDatabase().saveShowStatus();

          _myStore.put('EndTutorial', false);

          // if (_myStore.get('stores') == null) {
          //   _myStore.put('stores', true);
          // }
          // SaveInAppTour().savetodoTileStatus();
        } //this is where we set value to a shared preference. e.g sitehas been shown for particular widget

        );
  }

  //after initializing then we show it
  void _showInAppTour() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (_myStore.get('stores') == null) {
        _myStore.put('stores', true);
      }

      _myStore
          .delete('stores'); //personal flag to reset code to show all tutorials
      Future.delayed(const Duration(seconds: 2), () {
        ToDoDatabase().getShowStatus().then((value) {
          if (value == true || (ToDoDatabase().endTutorial() == false)) {
            print('ShowInAppTour can now run');
            tutorialCoachMark.show(context: context);
          } else {
            print('ShowInAppTour cannot run');
          }
        });
        // if (_myStore.get('stores') != true) {
        // tutorialCoachMark.show(context: context);
        // } else {}
      });
      // Future.delayed(const Duration(seconds: 2), () {
      // // if (isSaved == false) {
      //   tutorialCoachMark.show(context: context);
      // }
      // });
      // Future.delayed(Duration(seconds: 2), () {
      //   // SaveInAppTour().getTodoStatus().then((value) {
      //   // if (value == false) {
      //   print('Todo can now run');
      //   tutorialCoachMark.show(context: context);
      //   // } else {
      //   print('Todo cannot run');
      // }
      // });
    });
  }

  final _myBox = Hive.box('myBox');
  final _myStore = Hive.box('myStore');

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

    super.initState();
    _initializeInAppTourTarget();
    _showInAppTour();

    // db.createInitialData();
  }

  // void showWelcomeTutorial(BuildContext context) {
  //   tutorialCoachMark.show();
  // }

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
      _controller.clear();
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
        title: Text(
          key: welcomeKey,
          'TODO',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: addTaskKey,
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
          editTask: () => _editTask(index),
        ),
      ),
    );
  }
}
