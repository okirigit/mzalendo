
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:polls/start_quiz.dart';
import 'package:polls/variables.dart';

import 'login/login.dart';
import 'models/task.dart';
late LatLng _center  = const LatLng(-1.2950986402255833, 36.819301941975084);
class NearestTask extends StatefulWidget {
  const NearestTask({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<NearestTask> createState() => NearestTaskState();

}

class NearestTaskState extends State<NearestTask>{
late Marker marker ;
  Location location = Location();
  late GoogleMapController mapController;
  Set<Marker> markers = Set();
  String searchString = "";
Widget newWidget  = Center(child: CircularProgressIndicator(color: Colors.redAccent,),);

Widget items  = SizedBox.shrink();
  late LocationData _currentPosition;
  Marker marker_ =  Marker(
    markerId: MarkerId('My Current Location'),
    position: _center,
    infoWindow: InfoWindow(
      title: 'My Current Location',
      snippet: "GPS Location",
    ),
  );
  void setSearchString(String value) {
    print(value);
    Uri ur = Uri.parse("https://data-pal.herokuapp.com/searchItems?search=$value");
    setState(() {
      searchString = value;
    });
    if(value.length > 3){


      List<String> unique_types = task_type.toSet().toList();

 newWidget =  MarketItem(
  type: "Nearest Activities",
  tasks: myTasks__
      .where((p) => p.title.toLowerCase().contains(value.toLowerCase()))
      .toList(),
);

      setState((){
       items =  newWidget;
     });


    }




  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getLoc(controller);
  }

@override
void initState() {
}

  Future<LatLng>  getLoc(GoogleMapController controllerx) async{

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _center = const LatLng(-1.295428273853502, 36.820291095572685);

      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('alahhhh');

        _center = const LatLng(-1.295428273853502, 36.820291095572685);

      }
    }else {
      _currentPosition = await location.getLocation();

      LatLng _initialcameraposition = LatLng(_currentPosition.latitude!,_currentPosition.longitude!);
      _center = _initialcameraposition;
      final iconData = Icons.person;
      final pictureRecorder = PictureRecorder();
      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final iconStr = String.fromCharCode(iconData.codePoint);
      textPainter.text = TextSpan(
          text: iconStr,
          style: TextStyle(
            letterSpacing: 0.0,
            fontSize: 48.0,
            fontFamily: iconData.fontFamily,
            color: Colors.red,
          )
      );
      final canvas = Canvas(pictureRecorder);
      textPainter.layout();
      textPainter.paint(canvas, Offset(0.0, 0.0));
      final picture = pictureRecorder.endRecording();
      final image = await picture.toImage(48, 48);
      final bytes = await image.toByteData(format: ImageByteFormat.png);
      Uint8List? uint8list = bytes?.buffer.asUint8List();
      final bitmapDescriptor = BitmapDescriptor.fromBytes(uint8list!);
      _center = const LatLng(-1.295428273853502, 36.820291095572685);


      Marker marker_ =  Marker(

        markerId: MarkerId('My Current Location'),
        position: _center,
        infoWindow: InfoWindow(
          title: 'My Current Location',
          snippet: "GPS Location",
        ),
      );
      markers.add(marker_);

      controllerx.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target:_center,zoom: 10,
            ),
          )
      );


    }
    return _center;

  }
  List<Widget> myRows = [];

  @override
  Widget build(BuildContext context) {
    List<Task> myTasks_ = myTasks__;
    task_type = ['Locate','Explore','Survey'];

     items =  MarketItem(
        type: "Nearest Activities",
        tasks: myTasks_

    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, right: 0, top: 0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 2,
                        child: GoogleMap(

                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target:_center,
                            zoom: 13.0,
                          ),
                          markers: markers,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        elevation: 10,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Locate & Explorer tasks near you',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 30),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  minLines: 1,
                                  maxLines: 1,
                                  onChanged: setSearchString,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search Tasks . . . .',
                                    hintStyle: GoogleFonts.lato(
                                        color: Colors.grey[600],
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 400 ),
                  child: Container(
                    height: 330,
                    child:searchString.isNotEmpty ? newWidget : items,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 34.0, left: 18),
                    child: Icon(Icons.arrow_back_ios, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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



                    child: Text("Nearby Tasks" ,style: GoogleFonts.poppins(fontStyle: FontStyle.normal,fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black),),
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
          height: 330,
          child: ListView.separated(

            itemCount: tasks.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => _productTiles[index],
            separatorBuilder: (_, index) => const SizedBox(
              width: 2,

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
String image = "";
String image2 = "";
    switch (product.type){
      case "Explore":
        image = "assets/images/explore_bg.jpg";
        image2 = "assets/images/explore.png";
     //   tasK = FirstFeedUI(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
        break;
      case "Survey":
        image = "assets/images/survey.jpg";
        image2 = "assets/images/survey.png";

        ////   tasK = SurveyTask(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
        break;
      case "Locate":
        image = "assets/images/back1.jpg";
        image2 = "assets/images/locateTask.png";

        //  tasK = FirstFeedUI(views:product.views!,duration: product.time!,title: product.title,description: product.subtitle,amount: product.amount!,type: product.type,);
        break;




    }


    //Icon iconData = product.type.toLowerCase() == 'locate' ? Icon(FontAwesomeIcons.mapPin, size: 15,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 15,color: Colors.black);
   // Icon iconData2 = product.type.toLowerCase() == 'locate' ? Icon(Icons.my_location, size: 40,color: Colors.black,) : Icon(FontAwesomeIcons.list, size: 40,color: Colors.black);

    return Container(
      height: 330,
      child: GestureDetector(
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
        child: Padding(
          padding: const EdgeInsets.only(
              left: 0.0, right: 28, top: 5, bottom: 5),
          child: Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            elevation: 2,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 300,
                  width: 300,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: 150,
                          width:
                          MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: Image.asset(
                                image,
                                fit: BoxFit.cover),
                          )),
                      Positioned(
                        bottom: 130,
                        right:
                        210, //give the values according to your requirement
                        child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius:
                            BorderRadius.circular(100),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/logo.png"
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                          top: 180,
                          left: 25,
                          right: 5,
                          child: Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.orange[700],
                                fontSize: 13,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal),
                          )),
                      Positioned(
                          top: 200,
                          left: 25,
                          right: 5,
                          child: Text(
                            product.subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.black87,
                                fontSize: 14,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                          top: 236,
                          left: 25,
                          child: Text(
                            "Reward of KES "+product.amount!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.grey[800],
                                fontSize: 13,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal),
                          )),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),


      ),
    );
  }
}






