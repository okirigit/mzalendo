import 'package:flutter/material.dart';
import 'package:polls/components/input_container.dart';
import 'package:polls/constants.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.myController
  }) : super(key: key);

  final IconData icon;
  final String hint;

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        controller: myController,
        cursorColor: kPrimaryColor,

        decoration: InputDecoration(
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ));
  }
}