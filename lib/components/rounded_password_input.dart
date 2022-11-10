import 'package:flutter/material.dart';
import 'package:polls/components/input_container.dart';
import 'package:polls/constants.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    required this.hint,
    required this.myController

  }) : super(key: key);

  final String hint;
  final TextEditingController myController;


  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: myController,
        cursorColor: kPrimaryColor,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
  }
}