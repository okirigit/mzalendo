
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as locat;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:polls/variables.dart';

import '../MySharedPreferences.dart';


late LatLng _center  = const LatLng(-1.2950986402255833, 36.819301941975084);
class ReportCrime extends StatefulWidget {
  const ReportCrime({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<ReportCrime> createState() => ReportCrimeState();

}

class ReportCrimeState extends State<ReportCrime>{
  late Marker marker ;
  locat.Location location = new locat.Location();
  late GoogleMapController mapController;
  Set<Marker> markers = Set();

   String kGoogleApiKey = "API_KEY";


  final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
  final body = PlacesAutocompleteResult(
    onTap: (p) {
   //   displayPrediction(p, searchScaffoldKey.currentState!);
    },
    logo: Row(
      children: [FlutterLogo()],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );
  List<String> fileList = [];
  String searchString = "";
  Widget newWidget  = Center(child: CircularProgressIndicator(color: Colors.redAccent,),);
TextEditingController reportController =  TextEditingController();
  Widget items  = SizedBox.shrink();
  String cl_ = "";
  late locat.LocationData _currentPosition;
  Marker marker_ =  Marker(
    markerId: MarkerId('My Current Location'),
    position: _center,
    infoWindow: InfoWindow(
      title: 'My Current Location',
      snippet: "GPS Location",
    ),
  );

  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId("mycircle"),
    center: _center,
    radius: 4000,
  )]);
  List<Widget> myRows = [];
  Color wc = Colors.red;
  void pickImage() async {

    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if(photo != null){

      print(photo.path);

     // XFile xx = XFile(photo.path);
      String path_ = photo.path;

setState(() {
  fileList.add(path_);
  myRows.add(
      Image.file(File(path_))
  );
});
      //Image(image: await xFileToImage(xx));
      // updateImage(photo.path,);



    }else{
      print("not found");
    }
  }
  void pickVideo() async {

    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    if(photo != null){

      print(photo.path);

      XFile xx = XFile(photo.path);
      String path_ = photo.path;
      setState(() {
        fileList.add(path_);
        myRows.add(
            Image.file(File(path_))
        );
      });

      //Image(image: await xFileToImage(xx));
      // updateImage(photo.path,);



    }else{
      print("not found");
    }
  }

  void takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if(photo != null){

      print(photo.path);

      XFile xx = XFile(photo.path);
      String path_ = photo.path;

      setState(() {
        fileList.add(path_);
        myRows.add(
            Image.file(File(path_))
        );
      });
      //Image(image: await xFileToImage(xx));
     // updateImage(photo.path,);



    }else{
      print("not found");
    }

  }

  void cameraStart(String type,BuildContext ct) async {

    if(type == "camera"){
      AwesomeDialog(
        context: ct,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Select',
        desc: "Upload existing photo or take a new one",
        dismissOnTouchOutside: true,
        btnCancelOnPress: () {
          pickImage();
        },
        btnCancelText: "Pick Photo",
        btnOkText: "Take Photo",
        btnOkColor: Colors.orange,
        btnOkOnPress: (){
          takePhoto();
        }

      ).show();

    }
    if(type == "video") {
      pickVideo();
    }
    // print(photo?.path);

  }
  void updateCharacters(String value) {
    if(value.length < 50) {

      setState(() {
    cl_ = value.length.toString() + " Characters. ";

});
    }else{
      setState(() {
        wc = Colors.transparent;
      });
    }
  }
  void setSearchString(String value) {
    print(value);
    Uri ur = Uri.parse("https://data-pal.herokuapp.com/searchItems?search=$value");
    setState(() {
      searchString = value;
    });
    if(value.length > 3){


      List<String> unique_types = task_type.toSet().toList();


      setState((){
        items =  newWidget;
      });


    }




  }



  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getLoc(controller);
  }
  String _currentSelectedValue = '';
  List<String> opts = [
    "Crime",
    "Violence",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
  //  getLoc();
    _currentSelectedValue = opts[0];
    MySharedPreferences.instance.getStringValue("reportCrime").then((value) {
      //print(value);
      if(value == ""){
        createTutorial(context,reportTargets,"reportCrime");
      }


    });

    setState(() {
      cl_ = "";
      fileList = [];
      myRows = [];
    });
  }
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
String location_ = "Search location";
  Future<LatLng>  getLoc(GoogleMapController controllerx) async{

    bool _serviceEnabled;
    locat.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
       // _center = const LatLng(-1.295428273853502, 36.820291095572685);

      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == locat.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != locat.PermissionStatus.granted) {


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
     // _center = const LatLng(-1.295428273853502, 36.820291095572685);


       marker_ =  Marker(

        markerId: MarkerId('My Current Location'),
        position: _initialcameraposition,
        infoWindow: InfoWindow(
          title: 'My GPS Location',
          snippet: "GPS Location",
        ),
      );

      setState(() {
        circles = Set.from([Circle(
          circleId: CircleId("mycircle"),
          center: _initialcameraposition,
          fillColor: Colors.blue.withOpacity(0.7),
          strokeColor: Colors.transparent,
          radius: 4000,
        )]);
        markers.add(marker_);
      });

      controllerx.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target:_initialcameraposition,zoom: 13,
            ),
          )
      );


    }
    return _center;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(title: Positioned(  //search input bar
    top:10,
    child: InkWell(
        onTap: () async {
          var place = await PlacesAutocomplete.show(
              context: context,
              apiKey: "AIzaSyBRUqJOl9175b6FyRQ_8seFXUCTc60mkGM",
              mode: Mode.overlay,
              types: [],
              strictbounds: false,
              components: [Component(Component.country, 'ke')],
              //google_map_webservice package
              onError: (err){
                print("somethin wrong");
              }
          );

          if(place != null){
            setState(() {
              location_ = place.description.toString();
            });
            //form google_maps_webservice package
            final plist = GoogleMapsPlaces(apiKey:"AIzaSyBRUqJOl9175b6FyRQ_8seFXUCTc60mkGM",
              apiHeaders: await GoogleApiHeaders().getHeaders(),
              //from google_api_headers package
            );
            String placeid = place.placeId ?? "0";
            final detail = await plist.getDetailsByPlaceId(placeid);
            final geometry = detail.result.geometry!;
            final lat = geometry.location.lat;
            final lang = geometry.location.lng;
            var newlatlang = LatLng(lat, lang);


            //move map camera to selected place with animation
            mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
          }
        },
        child:Padding(
          padding: EdgeInsets.all(15),
          child: Card(
            child: Container(
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width - 40,
                child: ListTile(
                  title:Text(location_, style: TextStyle(fontSize: 18),),
                  trailing: Icon(Icons.search),
                  dense: true,
                )
            ),
          ),
        )
    )
),),
     //search autoconplete input
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 2,
                        child: GoogleMap(
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target:_center,
                            zoom: 13.0,
                          ),
                          markers: markers,
                          circles: circles,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        elevation: 10,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Report A Crime or Incident',
                              style: GoogleFonts.lato(
                                  color: Colors.grey[700],
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 30),
                                child: Text(
                              'Your personal information and location details will not be disclosed to any other third party.',
                              maxLines: 3,

                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 12,

                                  letterSpacing: 1,

                                  fontWeight: FontWeight.normal),
                            ),),),

                            SizedBox(height: 10,),
                           Container(
                             padding:const EdgeInsets.only(
                                 left: 20.0, right: 20, top: 10) ,
                             child:FormField<String>(
                               builder: (FormFieldState<String> state) {
                                 return InputDecorator(
                                   decoration: InputDecoration(

                                       errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                       hintText: 'Please select expense',
                                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                   isEmpty: false,
                                   child: DropdownButtonHideUnderline(
                                     child: DropdownButton<String>(
                                       value: _currentSelectedValue,
                                       isDense: true,
                                       onChanged: (value){
                                         setState(() {
                                           _currentSelectedValue = value!;
                                           state.didChange(value);
                                         });
                                       },
                                       items: opts.map((String value) {
                                         return DropdownMenuItem<String>(
                                           value: value,
                                           child: Text(value),
                                         );
                                       }).toList(),
                                     ),
                                   ),
                                 );
                               },
                             ),
                           ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 30),
                                child: TextField(
                                  textAlign: TextAlign.left,
                                  minLines:6,
                                  maxLines: 10,
                                  autocorrect: false,
                                  onChanged: updateCharacters,
                                  controller: reportController,
                                  decoration: InputDecoration( //cameraStart
                                    prefixIcon: IconButton(
                                      key:addImage,
                                      onPressed: (){
                                        cameraStart('camera',context);
                                      },
                                      icon: Icon(Icons.camera_alt,size: 30,color: Colors.red,),
                                    ),
                                    suffixIcon: IconButton(
                                      key:addVideo,
                                      onPressed: (){
                                        cameraStart('video',context);
                                      },
                                      icon:Icon(Icons.video_call_outlined,size: 30,color: Colors.red,),


                                      ),


                                    hintText: 'Describe the incident. Min character 100',
                                    hintStyle: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                      borderSide:
                                      BorderSide(color: Colors.grey),
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

                            SizedBox(
                              height: 3,
                            ),
                            Text(cl_,style: GoogleFonts.lato(color: wc,fontSize: 10),),
                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              child: fileList.isNotEmpty ? GridView.count(
                              padding: listViewPadding,
                              crossAxisCount: 1,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 24,
                              childAspectRatio: .78,
                              children: myRows,
                            ) : SizedBox.shrink(),
                            ),
                            Material(
                              color: Colors.orange,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              elevation: 2,
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width /
                                      1.15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)),
                                    border: Border.all(
                                        color: Colors.orange, width: 1),
                                  ),
                                  child: Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          reportCrime(reportController.text,fileList.toString(),context);

                                        },
                                        child: Text(
                                          'Submit',
                                          style: GoogleFonts.averageSans(
                                              color: Colors.white,
                                              fontSize: 14,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      )

                                  )),
                            )
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
final ImagePicker _picker = ImagePicker();




void reportCrime(report,files,context) async{

  if(report.length > 50 ) {
    Uri ur = Uri.parse(
        "http://www.task.mzalendopk.com/reportCrime?userId=$userId&report=$report&files=$files&locationName=Android test&latitude=&longitude=&category=");
    Response response = await get(ur);
    if(response.statusCode == 200) {

      AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Success',
          desc: "Report successfully posted. Thank you for your patriotism",
          dismissOnTouchOutside: false,

          btnOkText: "Dismiss",
          btnOkColor: Colors.orange,
          btnOkOnPress: () {
            Navigator.pop(context);
          }

      ).show();
    }else{
      AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Success',
          desc: "Report successfully posted. Thank you for your patriotism",
          dismissOnTouchOutside: false,

          btnOkText: "Dismiss",
          btnOkColor: Colors.orange,
          btnOkOnPress: () {
            Navigator.pop(context);
          }

      ).show();
    }
  }else{
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.LEFTSLIDE,
        title: 'Ooops!',
        desc: "SOmething went wrong",
        dismissOnTouchOutside: true,



    ).show();
  }

}


