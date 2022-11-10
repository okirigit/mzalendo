import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:polls/community/feedui/surveys.dart';
import 'package:polls/login/login.dart';

import 'package:polls/start_quiz.dart';
import 'package:polls/utils/constants.dart';
import 'package:polls/variables.dart';
import 'package:polls/widgets/articles_list_view_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'community/feedui/first.dart';
import 'firebase_options.dart';
import 'models/task.dart';
Widget xwig = Text("io");
List<Task> userTasks = [];


class TaskSearch extends StatefulWidget {
  const TaskSearch({Key? key, required this.title,required this.mytasks}) : super(key: key);


final List<Task> mytasks;
  final String title;

  @override
  State<TaskSearch> createState() => _MyMarketState();

}
//late bool fetched = false;

class _MyMarketState extends State<TaskSearch> {
  int _counter = 0;
  bool fetched = false;
  int _selectedIndex = 0;
  late Widget items;
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

    Uri ur = Uri.parse("https://data-pal.herokuapp.com/getFeed?userId=$userId");
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
void updateQs(){
  setState(() {
    main = items;

    // myTasks_ = myTasks;
  });
}


  @override
  Widget build(BuildContext context) {

    List<Task> myTasks_ = [];




    List<Widget> myTasks = [];
     print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

    //  initialiseLocations();
    task_type = ['Violence','Crime','Tasks'];

    //print(widget.mytasks);






    return FutureBuilder<String>(
      future: getTasks(userTasks), // async work
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: CircularProgressIndicator(color: Colors.black,));
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else{
          //  print(snapshot.data!);


            Map<dynamic,dynamic> data = jsonDecode(snapshot.data!);

            data.forEach((key, value) {

myTasks_.add(Task(amount:data[key]['amount'],type:"Tasks",title:data[key]['title'],time:data[key]['duration'],
                  subtitle: data[key]['subtopic'],id: data[key]['_id'],status: data[key]['status'],date:data[key]['date'],answers: {}
              ));
              //print(userTasks);
            });


          //  myTasks_ = userTasks;
         //   print(myTasks_[0].type);

            items = MarketItem(
              type: "Tasks",
              tasks: myTasks_


            );
            main = items;

            //updateQs();
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,

              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: onRefresh,
              onLoading: _onLoading,

              child: Scaffold(



                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: main,
                  )

                // This trailing comma makes auto-formatting nicer for build methods.
              ),
            );


          }
        }

      },
    );


  }


}





class MarketItem extends StatelessWidget {
  const MarketItem(
      {required this.tasks, required this.type, Key? key})
      : super(key: key);
  final String type;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
   //myTasks__ = userTasks;
    List<ProductTile> _productTiles =
    tasks.map((p) => ProductTile(product: p)).toList();



    return _productTiles.isEmpty
        ? const SizedBox.shrink()
        : Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only( left: 0, right:0,top:2),

          child: Container(
            height: 40,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children:<Widget>[
                  Container(
                    padding: EdgeInsets.only( left: 20, right:10),



                    child: Text(type ,style: GoogleFonts.poppins(fontStyle: FontStyle.normal,fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black),),
                  ),
                  Container(

                      padding: EdgeInsets.only( left: 20, right:10),
                      child:new GestureDetector(
                        onTap: (){

                        },
                        child: Text(tasks.length.toString() + ' task(s)',
                          style: GoogleFonts.averageSans(
                              color: Colors.grey[800],
                              fontSize: 17,
                              letterSpacing: 1,
                              fontWeight: FontWeight.normal),),

                      )
                  )
                ]
            ),


          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(

            itemCount: tasks.length,
            scrollDirection: Axis.vertical ,
            itemBuilder: (_, index) => _productTiles[index],
            separatorBuilder: (_, index) => const SizedBox(
              height: 5,
            ),
          ),
        ),
      ],
    );

  }
}
class ProductTile extends StatelessWidget {
  ProductTile({required this.product, GlobalKey? key}) : super(key: key);

  final Task product;
  late Widget tasK  ;
  @override
  Widget build(BuildContext context) {
    tasK = ArticlesListViewItem(data:product,onPressed: (){

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Meetup(task:product),

        ),
      );
    },);

       // FirstFeedUI(views:"0",duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
print(product);



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
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kaccentColor.withOpacity(0.25),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
              //border: Border.all(color: kaccentColor.withOpacity(0.2), width: 2),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child:tasK,
        )


    );
  }
}
Location location =  Location();
late LocationData _locationData;

void initialiseLocations() async {
  late bool _serviceEnabled ;
  late PermissionStatus _permissionGranted;



  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      _permissionGranted = await location.requestPermission();

    }
  }

  _locationData = await location.getLocation();

  print(_locationData);


}
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

