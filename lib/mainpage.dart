import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls/community/feedui/second.dart';
import 'package:polls/community/feedui/third.dart';
import 'package:polls/status.dart';

import 'community/feedui/first.dart';
import 'community/feedui/fivth.dart';
import 'community/feedui/fourth.dart';
import 'community/feedui/sixth.dart';
import 'models/search.dart';

class MainPage extends StatelessWidget {
  void setSearchString(String value) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: SingleChildScrollView(
          child: Column(
            children: [


              // Image.asset(
              //   'images/first.png',
              //   height: 300,
              // ),
              Container(color: Colors.white, height: 120, child: Status()),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Divider(),
              ),

              FirstFeedUI(views:"5",duration: "45 - 55 Minutes",title: "Gang Robery",description: "Locate gang members /activities near you",amount: "KES 100",type: "Locate",),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ));
  }
}
