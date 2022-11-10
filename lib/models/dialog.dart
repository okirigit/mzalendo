import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polls/question_screen.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image? img;

  const CustomDialogBox({ Key? key, required this.title, required this.descriptions, required this.text,  this.img}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400),),

              SizedBox(height: 22,),

              SizedBox(height: 15,),

              TextButton(
                style: ButtonStyle(
                  padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only( left: 10, right:10,top:10,bottom: 10)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),

                ),
                onPressed: () {


                },
                child: Text('START EXCERCISE',style: GoogleFonts.poppins(fontSize: 17,color: Colors.white),),
              )
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Icon(Icons.check_circle_sharp,color: Colors.red,size: 100,)
            ),
          ),
        ),
      ],
    );
  }
}