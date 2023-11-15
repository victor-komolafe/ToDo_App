import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// List<TargetFocus>allTargets

List<TargetFocus> addhomePageTargets({
  required GlobalKey welcomeKey,
  required GlobalKey addTaskKey,
}) {
  List<TargetFocus> targets = [];
  // List<TargetContent>
  targets.add(TargetFocus(
    identify: 'Target1',
    keyTarget: welcomeKey,
    alignSkip: Alignment.topRight,
    radius: 10,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.bottom,
        builder: (context, controller) => Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const <Widget>[
              Text(
                'Welcome to this TODO APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      )
    ],
  ));

  targets.add(TargetFocus(
    keyTarget: addTaskKey,
    alignSkip: Alignment.topRight,
    radius: 10,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) => Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                'This is where you can click to add a New Task',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    ],
  ));

  //Return targets
  return targets;
}

List<TargetFocus> toDoTileTargets({
  required GlobalKey editTaskKey,
  required GlobalKey deleteTaskKey,
  required GlobalKey taskCompeletedKey,
}) {
  List<TargetFocus> _targets = [];
  // List<TargetContent>
  _targets.add(TargetFocus(
    keyTarget: editTaskKey,
    alignSkip: Alignment.topRight,
    radius: 10,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) => Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Changed your mind about to Task? Click here to edit',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    ],
  ));

  _targets.add(TargetFocus(
    keyTarget: taskCompeletedKey,
    alignSkip: Alignment.topRight,
    radius: 10,
    paddingFocus: 2,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) => Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text(
                'Done with a Task? Click here to check the done box',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    ],
  ));

  _targets.add(TargetFocus(
    keyTarget: deleteTaskKey,
    alignSkip: Alignment.topRight,
    radius: 10,
    shape: ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) => Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const <Widget>[
              Text(
                'To delete a completed TODO, swipe on the completed task',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    ],
  ));
  // Return targets
  return _targets;
}
