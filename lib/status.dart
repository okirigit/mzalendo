import 'package:flutter/material.dart';

import 'package:polls/taskSearch.dart';
import 'package:polls/variables.dart';

import 'components/outline.dart';

class Status extends StatelessWidget {
  final kGradientBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.blue, Colors.redAccent]),
    border: Border.all(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(140),
  );

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(32),

    border: Border.all(color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:  [

            MyOutlineButton(next: TaskSearch(title: "Security",mytasks: myTasks__,),text: "Security"),
            MyOutlineButton(next: TaskSearch(title: "Violence",mytasks: myTasks__,),text: "Violence",),
            MyOutlineButton(next: TaskSearch(title: "Corruption",mytasks: myTasks__,),text: "Corruption",),
            MyOutlineButton(next: TaskSearch(title: "Politics",mytasks: myTasks__,),text: "Politics",),
            MyOutlineButton(next: TaskSearch(title: "Legal",mytasks: myTasks__,),text: "Legal"),

            MyOutlineButton(next: TaskSearch(title: "Business",mytasks: myTasks__,),text: "Business",),





          ],
        ),
      ),
    );
  }
}
