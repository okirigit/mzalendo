

import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polls/variables.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:location/location.dart';
import 'package:polls/MySharedPreferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key,this.title}) : super(key: key);
  final String? title;
  @override
  __MapScreenStateState createState() => __MapScreenStateState();
}

class __MapScreenStateState extends State<MapScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  String apiResponsne = '';
  late LocationData _currentPosition;
  late LatLng _center ;
  Location _location = Location();
  late GoogleMapController mapController;
  Set<Marker> markers = Set();
  late Location  location =  Location();
Widget icon_ = Icon(Icons.refresh_outlined,color: Colors.black,size: 30,);

  bool _notifications = true;
  late Marker marker ;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getLoc(controller);
  }
  void refresh(String value) => setState(() {
    apiResponsne = value;
  });


  getLoc(GoogleMapController controllerx) async{
    setState(() {
      icon_ = CircularProgressIndicator(color: Colors.black,);
    });
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('alahhhh');
        return;
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


    Marker marker_ =  Marker(
      icon: bitmapDescriptor,
        markerId: MarkerId('My Current Location'),
        position: _initialcameraposition,
        infoWindow: InfoWindow(
          title: 'My Current Location',
          snippet: "GPS Location",
        ),
      );
      controllerx.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target:_initialcameraposition,zoom: 16,
            ),
          )
      );


      setState(() {
        markers.add(marker_);
        icon_ = Icon(Icons.refresh_outlined,color: Colors.black,size: 30,);
      });
    }
}
  @override
  Widget build(BuildContext context) {
    // apiResponsne = '';

    return Scaffold(
      appBar: AppBar(
      actions: <Widget>[
        IconButton(onPressed: (){

          getLoc(mapController);
        }, icon: icon_),
    widget.title == null ? SizedBox.shrink() : IconButton(onPressed: (){}, icon: Icon(Icons.select_all_outlined,size: 30,color: Colors.red), )


      ],
        title: Text(widget.title ?? "Browse Tasks near you",style: GoogleFonts.robotoCondensed(color:Colors.black,fontStyle: FontStyle.normal,fontWeight: FontWeight.w300,fontSize: 20,),),
      ),

      body:
      GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        markers: markers,
      ),

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
Future<void> _handleSignOut(BuildContext context) async {
  await _ensureInitialized();
  await GoogleSignInPlatform.instance.disconnect();

  await MySharedPreferences.instance.setStringValue("onboarded", "true");
  await MySharedPreferences.instance.setStringValue("email", "");
  await MySharedPreferences.instance.setStringValue("name", "");

}




