import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDOTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              borderRadius: BorderRadius.circular(12),
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 147, 15, 15),
            )
          ],
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //       color: Color.fromARGB(255, 107, 44, 218),
        //       borderRadius: BorderRadius.circular(12)),
        //   height: 90,
        //   width: 1000,
        //   child: ListTile(
        //     contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        //     leading: Checkbox(value: taskCompleted, onChanged: onChanged),
        //     title: Text(
        //       taskName,
        //       style: TextStyle(
        //           color: taskCompleted ? Colors.white54 : Colors.white,
        //           decoration: taskCompleted
        //               ? TextDecoration.lineThrough
        //               : TextDecoration.none),
        //     ),
        //     // trailing: IconButton(onPressed: editTask, icon: Icon(Icons.edit)),
        //     tileColor: Color.fromARGB(255, 107, 44, 218),
        //   ),
        // ),

        child: Container(
          height: 90,
          width: 1000,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 107, 44, 218),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              //Text
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      color: taskCompleted ? Colors.white54 : Colors.white,
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
              // Padding(padding: EdgeInsets.only(left: viewI)),
              IconButton(
                  padding: EdgeInsets.only(right: 0),
                  onPressed: editTask,
                  icon: Icon(Icons.edit)),
            ],
          ),
        ),
      ),
    );
  }
}
