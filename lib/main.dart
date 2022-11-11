import 'dart:convert';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart';
import 'package:polls/account.dart';
import 'package:polls/map/maps.dart';
import 'package:polls/market.dart';
import 'package:polls/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:polls/taskSearch.dart';
import 'package:polls/variables.dart';
import 'package:polls/wallet.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'AppConfig.dart';
import 'MySharedPreferences.dart';
import 'components/navigation.dart';
import 'components/outline.dart';
import 'components/rounded_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'mainpage.dart';
import 'models/report_crime.dart';
import 'models/search.dart';
import 'models/task.dart';
import 'models/usercard.dart';

// ...

Object myQz = {};
List<Question> qs = [];

void main() async {
  // load our config
  //final config = await AppConfig.forEnvironment(env);

  // pass our config to our app
  runApp(MyApp("--no-sound-null-safety"));
}

class MyApp extends StatelessWidget {
  const MyApp(String s, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Mzalendo PK',
      theme: ThemeData(
        // This is the theme of your application.
        //


        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 0),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}


final GlobalKey taskItem = GlobalKey();
List<Widget> screens = [MyMarket(title: "Mzalendo PK",),TaskSearch(title: "Tasks near you",mytasks: [],),const ReportCrime(),const MyWallet(title: "Notifications"),SettingsScreen()];
class _MyHomePageState extends State<MyHomePage> {



  int _counter = 0;
  int _selectedIndex = 0;
  String searchString = "";

  List<Widget> myRows = [];
  List<Widget> searches = [];
   TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
final TextEditingController search_controller =  TextEditingController();
  Widget main = screens[1];
   //TextEditingController myController = TextEditingController() ;
  void setSearchString(String value) async {
    print(value);

    setState((){
      searchString = value;
    });


    if(value.length > 2){

      List<String> unique_types = task_type.toSet().toList();



   setState(() {
    // myRows = ff;
   });


    }




  }


  @override
  void initState()  {




  }

String _headline= 'Home';
  void setQsState(int pos,String value) {
    setState(() {

    qs[pos].answer = value;
    });
  }
  void getQuestions (Widget widg){
    setState(() {
main = widg;
    });
  }
  int _selectedIndex_ = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAligment = -1.0;
  List<CollapsibleItem> get _items {
    return [
      CollapsibleItem(
        text: 'Dashboard',
        icon: Icons.assessment,
        onPressed: () => setState(() => _headline = 'Home'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Ice-Cream',
        icon: Icons.icecream,
        onPressed: () => setState(() => _headline = 'Account'),
      ),
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Find Tasks'),
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    getQuestions(screens[widget.title]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,


title: MediaQuery.of(context).size.width > 992 ? BottomNavigationBar(
  backgroundColor: Colors.white,
  elevation: 5,
  showUnselectedLabels: true,
  selectedFontSize: 12,

  unselectedFontSize: 12,

  unselectedLabelStyle: GoogleFonts.roboto(color: Colors.grey,fontSize: 11,),
  unselectedIconTheme: IconThemeData(color: Colors.black38),
  selectedIconTheme: IconThemeData(color: Colors.blue,size: 25),
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.grey,
  selectedLabelStyle: GoogleFonts.roboto(color: Colors.black,
    fontStyle: FontStyle.normal,

    fontSize: 12,),

  iconSize: 25,
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(


      icon: Icon(
          FontAwesomeIcons.home, color: Colors.grey, key: Key("market")),
      label: 'Home',



    ),
    BottomNavigationBarItem(

      icon: Icon(
          FontAwesomeIcons.tasks, color: Colors.grey, key: Key("tasks")),
      label: 'Nearby Tasks',


    ),
    BottomNavigationBarItem(

      icon: Icon(
          FontAwesomeIcons.plusCircle, color: Colors.grey, key: Key("post")),
      label: 'Post',


    ),
    BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.bell, color: Colors.grey, key: Key("wallet"),),
      label: 'Notifications',

    ),
    BottomNavigationBarItem(

      icon: Icon(
          FontAwesomeIcons.user, color: Colors.grey,
          key: Key("account")),
      label: 'Profile',

    ),
  ],


  onTap: (value) {
    setState(() {
      _selectedIndex = value;

      // main = screens[value];
    });
  },

) : SizedBox.shrink(),

          actions: [
            Image.asset("assets/images/logo.png",height: 30,width : MediaQuery.of(context).size.width * 0.1 ),
            SearchBar(

              onChanged: setSearchString,

            ),

            Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.inbox)
                  ,
                )

            ),





          ],

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
        ),

        body: searchString.isNotEmpty
            ? GridView.count(
          padding: listViewPadding,
          crossAxisCount: 1,
          mainAxisSpacing: 14,

          crossAxisSpacing: 24,
          childAspectRatio: .78,
          children: myRows,
        )
            : Row(
              children: [
                MediaQuery.of(context).size.width > 992 ?  Container(

                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height  ,
                  margin: EdgeInsets.only(left: 50, top: 30),

                  child: Container(

                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height  ,
                    margin: EdgeInsets.only(right: 20, top: 30),

                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.album),
                            title: Text('Interesting Topics'),
                            subtitle: Text('Find tasks around you and contribute more'),
                          ),
                          Column(children: [


                          ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/cat.jpg',
                      width: 110.0,
                      height: 110.0,
                      fit: BoxFit.fill,
                    ),
                  ),

                          ],)
                        ],
                      ),
                    ),
                  )
                ) : SizedBox.shrink(),

                Container(
                  margin: EdgeInsets.only(left: 10 , top: MediaQuery.of(context).size.width > 992 ? 30 : 5),

                  width:MediaQuery.of(context).size.width > 992 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.95,

                  child:  screens[_selectedIndex],
                ),

                MediaQuery.of(context).size.width > 992 ?   Container(

                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height  ,
                  margin: EdgeInsets.only(right: 20, top: 30),

                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.album),
                          title: Text('Interesting Topics'),
                          subtitle: Text('Find tasks near you and contribute more'),
                        ),
                        Column(children: [
                           ListTile(
                            leading: Icon(Icons.location_on,color: Colors.blue,),
                            title: Text('Locater Tasks'),
                            subtitle: Text('Attend to tasks that require you to be present at a certain location'),
                            trailing: const MyOutlineButton(next: TaskSearch(title: "Security",mytasks: [],),text: "View",),

                          ),
                          ListTile(
                            leading: Icon(Icons.explore,color: Colors.blue,),
                            title: Text('Explorer Tasks'),
                            subtitle: Text('Go to places and take pictures or videos '),
                            trailing: const MyOutlineButton(next: TaskSearch(title: "Explorer",mytasks: [],),text: "View",),

                          ),
                          ListTile(
                            leading: Icon(Icons.info,color: Colors.blue,),
                            title: Text('Report an Incident'),
                            subtitle: Text('Noticed something around you.Help in creating a safer community by sharing the information'),
                            trailing: const MyOutlineButton(next: ReportCrime(),text: "Report",),

                          ),

                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(11.0),
                              image: DecorationImage(
                                image: NetworkImage("http://www.task.mzalendopk.com/images/community.jpg"),
                                fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Creating safer \n Communities',
                                  style: TextStyle(fontFamily: "RozhaOne",fontSize: 30,fontWeight: FontWeight.w700,color: Colors.white),
                                  textAlign: TextAlign.center,),


                              ),
                              //padding: <-- Using to shift text position a little bit for your requirement
                            ),

                        ],)
                      ],
                    ),
                  ),
                ) : SizedBox.shrink(),
              ],
            ),


        bottomNavigationBar: MediaQuery.of(context).size.width < 769  ?
        Stack(
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                          child: SizedBox(
                            key: market,
                            height: 40,
                            width: 40,
                          ),
                        )),
                    Expanded(
                        child: Center(
                          child: SizedBox(
                            key: wallet_,
                            height: 40,
                            width: 40,
                          ),
                        )),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          key: account,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 5,
                showUnselectedLabels: true,
                selectedFontSize: 12,

                unselectedFontSize: 12,

                unselectedLabelStyle: GoogleFonts.roboto(color: Colors.grey,fontSize: 11,),
                unselectedIconTheme: IconThemeData(color: Colors.black38),
                selectedIconTheme: IconThemeData(color: Colors.blue,size: 25),
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: GoogleFonts.roboto(color: Colors.black,
                  fontStyle: FontStyle.normal,

                  fontSize: 12,),

                iconSize: 25,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(


                    icon: Icon(
                        FontAwesomeIcons.home, color: Colors.grey, key: Key("market")),
                    label: 'Home',



                  ),
                  BottomNavigationBarItem(

                    icon: Icon(
                        FontAwesomeIcons.tasks, color: Colors.grey, key: Key("tasks")),
                    label: 'Nearby Tasks',


                  ),
                  BottomNavigationBarItem(

                    icon: Icon(
                        FontAwesomeIcons.plusCircle, color: Colors.grey, key: Key("post")),
                    label: 'Post',


                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      FontAwesomeIcons.bell, color: Colors.grey, key: Key("wallet"),),
                    label: 'Notifications',

                  ),
                  BottomNavigationBarItem(

                    icon: Icon(
                        FontAwesomeIcons.user, color: Colors.grey,
                        key: Key("account")),
                    label: 'Profile',

                  ),
                ],


                onTap: (value) {
                  setState(() {
                    _selectedIndex = value;

                   // main = screens[value];
                  });
                },

              ),

              // This trailing comma makes auto-formatting nicer for build methods.
            ]) :
        SizedBox.shrink()


    );
  }

}

Future<void>? _initialization;
Future<void> _ensureInitialized() {
  return _initialization ??= GoogleSignInPlatform.instance.init(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  )..catchError((dynamic _) {
    _initialization = null;
  });
}

GoogleSignInUserData? _currentUser;

void _setUser(GoogleSignInUserData? user, BuildContext context,getQuestions) async {
  _currentUser = user;
  if (user != null) {
logged = true;

//appSignIn
    List<String> nms = user.displayName.toString().split(" ");
    String fname = nms[0];
    String lname = nms[1];
    String email = user.email;


    Uri ur = Uri.parse(
        "https://data-pal.herokuapp.com/appSignIn?fname=$fname.&lname=$lname&email=$email");
    Response response = await get(ur);

     userId = response.body.toString();

await MySharedPreferences.instance.setStringValue("email", user.email.toString());
await MySharedPreferences.instance.setStringValue("name", user.displayName.toString());
   await MySharedPreferences.instance.setStringValue("userId", userId);
    getQuestions(MyMarket(title: "Task Marketplace"));



  }else {

    _signIn(context,getQuestions);
  }

}

Future<void> _signIn(BuildContext context,getQuestions) async {
  await _ensureInitialized();
  final GoogleSignInUserData? newUser =
  await GoogleSignInPlatform.instance.signInSilently();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(newUser!.email),
    duration: Duration(milliseconds: 4000),
  ));


}







