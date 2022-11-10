import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton({Key? key, required this.text, required this.next, });
final String text;
final Widget next;

  @override
  Widget build(BuildContext ct) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only( left: 10, right:10,top:5,bottom: 5),
      child: OutlinedButton(

      style: ButtonStyle(
       // padding:MaterialStateProperty.all()),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled))
                return Colors.blue;
              return Colors.blue.withOpacity(0.2); // Defer to the widget's default.
            }),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled))
                return Colors.white;
              return Colors.white; // Defer to the widget's default.
            }),




      ),
      onPressed: () {
        Navigator.push(
            ct,
            MaterialPageRoute(
                builder: (_) => next)

        );

        debugPrint('Received click');
      },
      child: Text("#"+text,style: GoogleFonts.roboto(color: Colors.blue,fontSize: 16,),),



    ),);
  }
}
