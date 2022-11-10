import 'package:flutter/material.dart';
import 'package:polls/constants.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 1,
      decoration: BoxDecoration(

        color: kPrimaryColor.withAlpha(50)
      ),

      child: child
    );
  }
}