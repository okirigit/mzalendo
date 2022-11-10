import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'MySharedPreferences.dart';
import 'models/task.dart';
GlobalKey wallet_ = GlobalKey();
GlobalKey search = GlobalKey();
GlobalKey market = GlobalKey();
GlobalKey account = GlobalKey();
GlobalKey reportInfo = GlobalKey();
GlobalKey nearTask = GlobalKey();
GlobalKey addImage = GlobalKey();
GlobalKey addVideo = GlobalKey();


late List<Task> myTasks__;

late List<String> task_type ;
late TutorialCoachMark tutorialCoachMark;

List<TargetFocus> reportTargets = [
  TargetFocus(
    identify: "addImage",
    keyTarget: addImage,
    alignSkip: Alignment.topRight,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/pick_img.png"),

                Text(
                  "Use this feature Attach any Images you feel are related to this incident",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),

  TargetFocus(
    identify: "addVideo",
    keyTarget: addVideo,
    alignSkip: Alignment.topRight,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/video.png"),

                Text(
                  "Use this feature Attach any Videos you feel are related to this incident",
                  style:GoogleFonts.lato(color: Colors.white,fontSize: 25)
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),

];

List<TargetFocus> targets = [

  //nearTask
  TargetFocus(
    identify: "nearTask",
    keyTarget: nearTask,
    alignSkip: Alignment.topRight,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/forms.webp"),

                Text(
                  "Find tasks you can do here. They range from security, Locating places and filling e-survey forms",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),

  TargetFocus(
    identify: "report",
    keyTarget: reportInfo,
    alignSkip: Alignment.topRight,
    contents: [
      TargetContent(
        align: ContentAlign.top,
        builder: (context, controller) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/forms.webp"),

                Text(
                  "Find tasks you can do here. They range from security, Locating places and filling e-survey forms",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),

  TargetFocus(
  identify: "market",
  keyTarget: market,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/images/forms.webp"),

              Text(
                "Find tasks you can do here. They range from security, Locating places and filling e-survey forms",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
),
  TargetFocus(
  identify: "wallet",
  keyTarget: wallet_,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/images/forms.webp"),

              Text(
                "Find tasks you can do here. They range from security, Locating places and filling e-survey forms",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
),

  TargetFocus(
  identify: "search",
  keyTarget: search,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Image.asset("assets/images/withdraw.webp"),
              Text(

                "Searh for tasks using location or activity based(i.e Security, Dagoretti)",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
),
  TargetFocus(
  identify: "account",
  keyTarget: account,
  alignSkip: Alignment.topRight,
  contents: [
    TargetContent(
      align: ContentAlign.top,
      builder: (context, controller) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset("assets/images/profile.png"),

              Text(
                "Manage your profile here. Including personal details and other activities",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ],
)];


void showTutorial(context) {
  tutorialCoachMark.show(context: context);
}

void createTutorial(context,List<TargetFocus> list,String path) {
  tutorialCoachMark = TutorialCoachMark(
    targets: list,
    colorShadow: Colors.red,
    textSkip: "SKIP",
    paddingFocus: 10,
    opacityShadow: 0.8,
    onFinish: () async {
      if(path == "reportCrime") {
        await MySharedPreferences.instance.setStringValue("reportCrime", "true");
      }else{
        await MySharedPreferences.instance.setStringValue("introduced", "true");

      }
      print("finish");
    },
    onClickTarget: (target) {
      print('onClickTarget: $target');
    },
    onClickTargetWithTapPosition: (target, tapDetails) {
      print("target: $target");
      print(
          "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
    },
    onClickOverlay: (target) {
      print('onClickOverlay: $target');
    },
    onSkip: () {
      print("skip");
    },
  );
  tutorialCoachMark.show(context: context);
}

bool logged = false;
String email = "";
String name = "Guest";
String userId =  "";

Future getuser() async{
  name = await MySharedPreferences.instance.getStringValue("name");

  email = await MySharedPreferences.instance.getStringValue("email");
  userId = await MySharedPreferences.instance.getStringValue("userId");
}
String baseUrl = "https://data-pal.herokuapp.com";
var listViewPadding =
const EdgeInsets.symmetric(horizontal: 16, vertical: 24);
List<Task> myActivities_ = [];
MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

MaterialColor black = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);

bool fetched = false;
Future<String>  getTasks(List<Task> userTasks) async {

  Uri ur = Uri.parse("http://www.task.mzalendopk.com/getFeed?userId=lk");
  const url_ = "mongodb+srv://mzalendopk:mzalendo2022@cluster0.u3y6lwf.mongodb.net/test";


   // await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
    Response response = await get(ur);
    String content = response.body;
//print(content);
   // print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

   // userTasks = [];
    //for(var i = 0; var i < )

    fetched = false;
  //  print(userTasks);
   //print(j);
    return response.body.toString();

}

