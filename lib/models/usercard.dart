import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:polls/variables.dart';



class UserCard extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UserCard> {
  bool _isFollow = false;

  @override
  void initState() {
    // Define the model
    String user =  name ?? "Guest";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        accentColor: Colors.green,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      home: Scaffold(

        body:Text("mm"),
      ),
    );
  }
}