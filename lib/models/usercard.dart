import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_profile_card/flutter_profile_card.dart';
import 'package:flutter_profile_card/models/Profile.dart';
import 'package:polls/variables.dart';



class UserCard extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<UserCard> {
  bool _isFollow = false;
  late ProfileModel _profileModel;

  @override
  void initState() {
    // Define the model
    String user =  name ?? "Guest";
    _profileModel = ProfileModel(
      uid: '1234567890',
      username: 'Welcome ' +name,
      status: 'We Effectively Collect the data you need to drive impact in your organisation whilst creating  safer communities  through technology.',
      avatarURL: 'https://picsum.photos/200',
      followers: 1,
      followings: 1234,
    );

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

        body: ProfileCard(
          // Add the model in the widget parameter
          profile: _profileModel,
          // Capture the follow event
          onFollowed: (ProfileModel profile) {
          //  print(profile.toJson());
            setState(() {
              // Database code...
              _isFollow = !_isFollow;

              _profileModel.isFollowed = _isFollow;
              _profileModel.updateFollowers = _isFollow ? 2 : 1;
            });
          },
        ),
      ),
    );
  }
}