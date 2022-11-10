import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geoLoc;
import 'package:polls/widgets/article_page.dart';
import 'package:polls/widgets/article_view.dart';
import '../../models/posts.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:polls/community/feedui/post_widget.dart';
import 'package:polls/community/feedui/surveys.dart';
import 'package:polls/login/login.dart';
import 'package:polls/models/postmodel.dart';
import 'package:polls/models/usermodel.dart';

import 'package:polls/question_screen.dart';
import 'package:polls/start_quiz.dart';
import 'package:polls/status.dart';
import 'package:polls/variables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'community/feedui/first.dart';
import 'firebase_options.dart';
import 'models/task.dart';
Widget xwig = Text("io");


class MyMarket extends StatefulWidget {
  const MyMarket({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyMarket> createState() => _MyMarketState();

}
//late bool fetched = false;

class _MyMarketState extends State<MyMarket> {
  int _counter = 0;
  bool fetched = false;
  int _selectedIndex = 0;

  List<Widget> myRows = [];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget main = Center(child: CircularProgressIndicator(color: Colors.black,),);
  //TextEditingController myController = TextEditingController() ;

  void getQuestions (Widget widg){
    setState(() {
      main = widg;
    });
  }


  Future  getData(getQuestions) async {

    Uri ur = Uri.parse("http://www.task.mzalendopk.com/appReports");

    const url_ = "mongodb+srv://mzalendopk:mzalendo2022@cluster0.u3y6lwf.mongodb.net/test";

    if(fetched == false ) {

      await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      Response response = await get(ur);
      String content = response.body;
      print(jsonDecode(response.body.toString()));
      return jsonDecode(response.body.toString());

    }
  }
  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }
  void onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  Future<List<dynamic>> startFire() async {
    List<geoLoc.Placemark> placemarks = await geoLoc.placemarkFromCoordinates(-1.2207733024226128, 36.87718785946367);

    return placemarks;
    //getData();
  }

  @override
  void initState(){


  }
  Widget build(BuildContext context) {
    if(userId != ''){

    }else {

    }
    List<Widget> myTasks_ = [];
    List<PostModel> myTasks = [];

    task_type = [];
  //  initialiseLocations();
if(fetched == false){

    //BoxConstraints viewportConstraints = BoxConstraints();
    getData(getQuestions).then((value) {
      // print(snapshot.value[0]);
      fetched = true;
      myTasks__ = [];
      //for(var i = 0; var i < )
      List<dynamic> data = value;
      int p = 0;
      data.forEach((value) {
        print(value);
        String dd = value['date'].toString().substring(0,10);
        List<dynamic> ims = value['images'];
        task_type.add(value['category']);
        PostModel md = PostModel();
        md.id = value['_id'];
        md.title = value['category'] ;
        md.category = value['category'] ;
        md.tweetText = value['report'];
        md.date = "Posted on " +dd;
        md.likes = ["Amin","f","dfdf","Dfdf"];
        md.comments = ["Amin","f","dfdf","Dfdf"];
        md.uploadTime= value['date'];
        md.location =  md.title + " in "+value['locationName'];
        md.tweetImage = ims.isNotEmpty ? value['images'][0] : '';




        myTasks.add(md);
        p++;
      }

      );
      List<String> unique_types = ["Latest in Your Area"];

Widget tt = MarketItem(tasks: myTasks, type: unique_types[0]);
     //myRows = tt;


      setState(() {
        main = Column(
          children: [ Container(
              margin: EdgeInsets.only(top: 5,left: 10,right: 10),

               height: 40, child: Center(child: Status(),)),

            FutureBuilder<List<dynamic>>(
                future: startFire(), // async work
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

                  if( snapshot.connectionState == ConnectionState.waiting){
                    return  Center(child: CircularProgressIndicator(color: Colors.black,));
                  }else{
                    if (snapshot.hasError)
                      return Text(snapshot.error.toString());
                    else {
                      List<dynamic> datax = snapshot.data!;
                      geoLoc.Placemark l = datax[0];


return Center(child: Text(l.administrativeArea.toString()),);
                    }

                  }
                }
            ),

            tt],
        );

        // myTasks_ = myTasks;
      });
    });
  }

    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,

        header: WaterDropHeader(),
    controller: _refreshController,
    onRefresh: onRefresh,
    onLoading: _onLoading,

     child: Scaffold(


      body:
      ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),

     child: SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child: main,
      )
     )

      // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
  }


}

void postData(String path,dynamic obj){
  DatabaseReference ref = FirebaseDatabase.instance.ref(path);
  print(obj);
  //ref.set(obj);
}



class MarketItem extends StatelessWidget {
  const MarketItem(
      {required this.tasks, required this.type, Key? key})
      : super(key: key);
  final String type;
  final List<PostModel> tasks;

  @override
  Widget build(BuildContext context) {
    List<PostWidget> _productTiles =
    tasks.map((p) => PostWidget(datamodel: p,index: tasks.indexOf(p))).toList();



    return _productTiles.isEmpty
        ? const SizedBox.shrink()
        : Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        SizedBox(

height:MediaQuery.of(context).size.height,
          child: Container(
            margin: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 180),


        child:  ListView.separated(

            itemCount: tasks.length,
            scrollDirection: Axis.vertical ,
            itemBuilder: (_, index) => GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>  ArticlePage(data: _productTiles[index].datamodel)

        ),
      );

    },
    child:_productTiles[index]),
            separatorBuilder: (_, index) => const SizedBox(
              height: 15
              ,
            ),
          ),
        ),



    )]);
  }
}
class ProductTile extends StatelessWidget {
   ProductTile({required this.product, GlobalKey? key}) : super(key: key);

  final Task product;
  late Widget     tasK = FirstFeedUI(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);

   @override
  Widget build(BuildContext context) {

switch (product.type){
  case "Explore":
    tasK = FirstFeedUI(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
    break;
  case "Survey":
    tasK = SurveyTask(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
    break;
  case "Locate":
    tasK = FirstFeedUI(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
    break;




}


    Icon iconData = product.type.toLowerCase() == 'locate' ? Icon(FontAwesomeIcons.mapPin, size: 15,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 15,color: Colors.black);
    Icon iconData2 = product.type.toLowerCase() == 'locate' ? Icon(Icons.my_location, size: 40,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 40,color: Colors.black);

    return GestureDetector(
      key: const Key('taskItem'),
      onTap: () {
        if(userId != ''){
          Map<String, dynamic>? dd = {};
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Meetup(task:product),

            ),
          );
        }else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Login(),
            ),
          );
        }
      //  SystemSound.play(SystemSoundType.click);

      },
      child:Container(
          child:tasK,


        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
      color: Colors.white,

    ),
      )


    );
  }
}
late LocationData _locationData;

void getAtivities() async {

  if(myActivities_.isEmpty ) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('/data/Customers/'+userId).get();

    if (snapshot.exists) {

      //return snapshot.value;
    }else {

    }
  }
}

