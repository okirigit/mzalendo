import 'package:flutter/cupertino.dart';

class Task {
  final String type;

  final String  title;
  final String subtitle;
  final String? time;
  final String? amount;
  final String id;
  final String? status;
  final String? date;
  final String? views;
  final Map<String, dynamic> answers;




  Task(
      { this.amount,
        this.views,
        required this.answers,
        required this.type,
        required this.title,
        required this.time,
        required this.subtitle,
        required this.id,
        this.status,
        this.date,



      });
}
