import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:polls/question_screen.dart';
import 'package:polls/variables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'login/login.dart';
import 'models/task.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyWallet> createState() => _MyWalletState();

}
//late bool fetched = false;

class _MyWalletState extends State<MyWallet> {
  int _counter = 0;
  bool fetched = false;
  bool isFetched = false;
  int _selectedIndex = 0;
  List<String> task_type = [];
  List<Widget> myRows = [];
  late List<Task> tasks_  = [];

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget main = Center(child: CircularProgressIndicator(color: Colors.black,),);
  //TextEditingController myController = TextEditingController() ;

  void _incrementCounter() {
    setState(() {


      _counter++;
    });
  }
  List<Widget> myTasks_ = [];
  List<Widget> myTasks = [];

  //  initialiseLocations();
  List<String> unique_types = ["My Activities","Reported Crimes"];


  Future<dynamic> getData(id) async {

    if(isFetched == false){

      Response response = await get(Uri.parse(baseUrl+'/getActivity?id='+userId));
      String content = response.body;
      isFetched = true;
      print("kkk");

      List<dynamic> valuex = jsonDecode(response.body);
  print(valuex.length);
      print(valuex);
      for(var i = 0; i < valuex.length;i++){
        tasks_.add(Task(amount:"",answers: valuex[i]['Answers'][userId],date: valuex[i]["Answers"][userId]['date'], type: "My Activities", title: valuex[i]["title"], status: valuex[i]["Answers"][userId]['status'], subtitle: "", id: valuex[i]["_id"], time: ''));

      }
      Response responseb = await get(Uri.parse(baseUrl+'/getReports?id='+userId));
      List<dynamic> valuex_ = jsonDecode(responseb.body);
      print(valuex_[0]);
      print(valuex_[valuex_.length - 1]);
      for(var i = 0; i < valuex_.length;i++){
        print(valuex_[i]['date']);
        tasks_.add(Task(amount:"",answers: {},date: "", type: "Reported Crimes", title: "Report Posted", status: "Pending Review", subtitle: "", id: "", time: ''));

      }
      tasks_ = tasks_;
      Widget wallo = WalletItem(height:140,tasks: [Task(date:"",answers: {}, amount: "0", type: "My Wallet", title: "My Wallet Balance", time: "",subtitle: "",  id: "")], type:  "My Wallet");
      Widget payment = WalletItem(height:140,tasks: [Task(date:"Safaricom Airtime",answers: {},amount: "", type: "Payment", title: "Your acount will be automatically topped up when your submition is approved!", time: "",subtitle: "Your acount will be automatically topped up when your submition is approved!",  id: "")], type:  "Wallet Options");
myRows.add(wallo);
myRows.add(payment);
myRows.add( ActivityItem(

  type: "My Activities",
  tasks: tasks_,
));


      setState(() {
        main =   SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: myRows,),

        );

      });
      return valuex;

      final ref = FirebaseDatabase.instance.ref();
      List<dynamic> questionaire__ = [];
      isFetched = true;
      final snapshot = await ref.child('/data/Customers/' + userId+"/Activities").get();
      if (snapshot.exists) {




        // print(questionaire_);
        // Map questions_ = data['Questions'];

      } else {
        print('No data available.');
      }
    }
  }

  void setQsState(int pos,String value) {
    setState(() {

      // qs[pos].answer = value;
    });
  }
  void getQuestions (Widget widg){
    setState(() {
      main = widg;
    });
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
  @override
  Widget build(BuildContext context) {


     getData("").then((valuex) {


    });


    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,

      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: onRefresh,
      onLoading: _onLoading,

      child: Scaffold(


          body: main

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }


}
class WalletItem extends StatelessWidget {
  const WalletItem(
      {required this.tasks, required this.type,required this.height, Key? key})
      : super(key: key);
  final String type;
  final double height;
  final List<Task> tasks ;



  @override
  Widget build(BuildContext context) {
    List<Wallet> _productTiles =
    tasks.map((p) => Wallet(product: p)).toList();



    return _productTiles.isEmpty
        ? const SizedBox.shrink()
        : Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only( left: 0, right:0,top:10),

          child: Container(
            height: 40,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children:<Widget>[
                  Container(
                    padding: EdgeInsets.only( left: 20, right:10),
                    child:             Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_search_outlined,
                            color: Colors.orange[400],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 4),
                            child: Text(
                              type,
                              style: GoogleFonts.lato(
                                  color: Colors.grey[900],
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                ]
            ),


          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(

          height: height,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: tasks.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => _productTiles[index],
            separatorBuilder: (_, index) => const SizedBox(
              width: 4,
            ),
          ),
        ),
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem(
      {required this.tasks, required this.type, Key? key})
      : super(key: key);
  final String type;

  final List<Task> tasks ;



  @override
  Widget build(BuildContext context) {
    List<MyActivities> _productTiles =
    tasks.map((p) => MyActivities(product: p)).toList();



    return _productTiles.isEmpty
        ? const SizedBox.shrink()
        : Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only( left: 0, right:0,top:10),

          child: Container(
            height: 40,

            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children:<Widget>[
                  Container(
                    padding: EdgeInsets.only( left: 20, right:10),
child:             Padding(
  padding: const EdgeInsets.only(left: 20.0),
  child: Row(
    children: [
      Icon(
        Icons.person_search_outlined,
        color: Colors.orange[400],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 4),
        child: Text(
          type,
          style: GoogleFonts.lato(
              color: Colors.grey[900],
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.justify,
        ),
      ),
    ],
  ),
),

                  ),

                ]
            ),


          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(

          height: 400,
          child: ListView.separated(

            itemCount: tasks.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) => _productTiles[index],
            separatorBuilder: (_, index) => const SizedBox(
              width: 4,
            ),
          ),
        ),
      ],
    );
  }
}
class MyActivities extends StatelessWidget {
  const MyActivities({required this.product, Key? key}) : super(key: key);

  final Task product;

  @override
  Widget build(BuildContext context) {
    if(userId != ''){

    }else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
      );
    }
    Icon iconData2 = product.id.toLowerCase() == '' ? Icon(FontAwesomeIcons.wallet, size: 40,color: Colors.red,) : Icon(Icons.task, size: 40,color: Colors.black);
    //Icon iconData2 = product.type.toLowerCase() == 'My Activities' ? Icon(Icons.task, size: 40,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 40,color: Colors.black);

    return GestureDetector(
      onTap: () {
        if(product.id != ""){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuestionScreen(title: product.id,url: "load",answers__:product.answers,),
            ),
          );
        }
        //  SystemSound.play(SystemSoundType.click);

      },
      child: SizedBox(
        width: 380,





        child: Card(
          shadowColor: Colors.black,
          elevation:5,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),

          child: Container(
            padding: const EdgeInsets.all(6),


            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: <Widget>[
                Container(
                    height: 87,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 13),
                              child:Text(product.title,  style: GoogleFonts.lato(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),),



                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Container(
                                    // height: 100,
                                    // width: MediaQuery.of(context).size.width / 1.1,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.orange),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12, top: 4, bottom: 4),
                                      child: Text(
                                        product.status!,
                                        style: GoogleFonts.lato(
                                            color:product.status == 'Rejected' ? Colors.red[400] :Colors.orange[400] ,
                                            fontSize: 13,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  product.date!,
                                  style: GoogleFonts.lato(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange[400],
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Wallet extends StatelessWidget {
  const Wallet({required this.product, Key? key}) : super(key: key);

  final Task product;

  @override
  Widget build(BuildContext context) {
    if(userId != ''){

    }else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
      );
    }
    Icon iconData2 = product.id.toLowerCase() == '' ? Icon(FontAwesomeIcons.wallet, size: 40,color: Colors.red,) : Icon(Icons.task, size: 40,color: Colors.black);
    //Icon iconData2 = product.type.toLowerCase() == 'My Activities' ? Icon(Icons.task, size: 40,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 40,color: Colors.black);

    return GestureDetector(
      onTap: () {
        if(product.id != ""){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuestionScreen(title: product.id,url: "load",answers__:product.answers,),
            ),
          );
        }
        //  SystemSound.play(SystemSoundType.click);

      },
      child: SizedBox(
        width: 380,





        child: Card(
          shadowColor: Colors.black,
          elevation:5,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),

          child: Container(
            padding: const EdgeInsets.all(6),


            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: <Widget>[

                ListTile(
                  leading: product.type == "My Wallet" ? Image.asset("assets/images/dollar.png") : Image.asset("assets/images/gear.png"),
                  title:product.amount != "" ? Text("KES " + product.amount!,style: GoogleFonts.poppins(color:Colors.red,fontStyle: FontStyle.normal,fontWeight: FontWeight.w800,fontSize: 20,),) :
                  Text(product.date!,style: GoogleFonts.lato(color:Colors.black,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 14,),),
                  trailing:product.type == "My Wallet" ? SizedBox.shrink(): IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.black,)),
                  subtitle: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 3,),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child:Text(product.title,style: GoogleFonts.lato(color:Colors.grey,fontStyle: FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 12,)),
                        ),
                        SizedBox(height: 10,),

                        SizedBox(height: 5,),
                       Text(product.type == "My Activities" ? product.status! :  "",style: GoogleFonts.robotoSlab( color:Colors.blue,fontStyle: FontStyle.normal,fontWeight: FontWeight.w500,fontSize: 14,),),

                      ],),
                  ),


                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}



