import 'package:flutter/cupertino.dart';

class Question {
  final String question;

  dynamic  answer;
  final String id;
  late String? type;
  late TextEditingController? controller;


  Question(
      {required this.question,
required this.id,
         this.controller,

        this.answer,
        this.type,
      });
}
