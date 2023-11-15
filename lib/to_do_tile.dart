import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/in_app_tour_target.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ToDOTile extends StatefulWidget {
  final String taskName;
  final bool taskCompleted; //for value of Checkbox
  Function(bool?)? onChanged; //for onChanged textbox

  void Function()? editTask;
  Function(BuildContext)? deleteTask;
  ToDOTile(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.editTask,
      required this.deleteTask});

  @override
  State<ToDOTile> createState() => _ToDOTileState();
}

class _ToDOTileState extends State<ToDOTile> {
  final taskCompeletedKey = GlobalKey();

  final editTaskKey = GlobalKey();
  bool isSaved = false;

  final deleteTaskKey = GlobalKey();

  //tutorialMarkCoach codes
  late TutorialCoachMark tutorialCoachMark;

  //initailizing
  void _initializeInAppTourTarget() {
    tutorialCoachMark = TutorialCoachMark(
        targets: toDoTileTargets(
            editTaskKey: editTaskKey,
            deleteTaskKey: deleteTaskKey,
            taskCompeletedKey: taskCompeletedKey),
        colorShadow: Colors.black,
        hideSkip: false,
        opacityShadow: 0.8,
        onFinish: () {
          ToDoDatabase().stopShowStaus();
          _myStore.put('EndTutorial', false);
          print('Completed TODO TILE');
        }
        //this is where we set value to a shared preference. e.g sitehas been shown for particular widget
        );
  }

  final _myStore = Hive.box('myStore');
  // ToDoDatabase db = ToDoDatabase();

  void _showInAppTour() {
    Future.delayed(Duration(seconds: 12), () {
      ToDoDatabase().getShowStatus().then((value) {
        if (value == true || (ToDoDatabase().endTutorial()) == true) {
          print('Todo can now run');
          tutorialCoachMark.show(context: context);
        } else {
          print('Todo cannot run');
        }
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(seconds: 2), () {
    //     tutorialCoachMark.show(context: context);
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    //
    super.initState();
    _initializeInAppTourTarget();

    _showInAppTour();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteTask,
              borderRadius: BorderRadius.circular(12),
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 147, 15, 15),
            )
          ],
        ),
        child: Container(
          key: deleteTaskKey,
          height: 90,
          width: 1000,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 107, 44, 218),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                key: taskCompeletedKey,
                value: widget.taskCompleted,
                onChanged: widget.onChanged,
                activeColor: Colors.black,
              ),

              //Text
              Expanded(
                child: Text(
                  widget.taskName,
                  style: TextStyle(
                      color:
                          widget.taskCompleted ? Colors.white54 : Colors.white,
                      decoration: widget.taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              // Padding(padding: EdgeInsets.only(left: viewI)),
              IconButton(
                  key: editTaskKey,
                  padding: EdgeInsets.only(right: 0),
                  onPressed: widget.editTask,
                  icon: Icon(Icons.edit)),
            ],
          ),
        ),
      ),
    );
  }
}
