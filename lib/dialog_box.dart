// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:to_do_app/task_buttons.dart';

class DialogBox extends StatelessWidget {
  final Controller;

  //onsave method
  VoidCallback onSave;
  VoidCallback onCancel;

  //onCa
  DialogBox(
      {super.key,
      required this.Controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      backgroundColor: const Color.fromARGB(255, 170, 146, 237),
      content: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 170, 146, 237),
          borderRadius: BorderRadius.circular(10),
        ),

        height: 130,

        //get user input
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: Controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(20),
                hintText: 'Add new task',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TaskButtons(text: 'Save', onPressed: onSave),
                Padding(padding: EdgeInsets.all(10)),
                TaskButtons(text: 'Cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),

        // foregroundDecoration: BoxDecoration(color: Colors),
      ),
    );
  }
}
