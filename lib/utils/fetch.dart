
import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../MySharedPreferences.dart';
import '../main.dart';
import '../models/user.dart';
import '../variables.dart';

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


void setUser(GoogleSignInUserData? user, BuildContext context, updateScreen) async {
  _currentUser = user;
  if (user != null) {
    await MySharedPreferences.instance.setStringValue("account","google");

    MySharedPreferences.instance.setStringValue("userId", user.id.toString()).then((value) {
      userId = value;
      MySharedPreferences.instance.setStringValue("email", user.email.toString()).then((value) {
        print(value);
        email = value;
        MySharedPreferences.instance.setStringValue("name", user.displayName.toString()).then((value) {
          print(value);
          name = value;

          updateScreen(const MyHomePage(title: 0));
        });
      });
    });
  }

}

void initUser(UserObj user,BuildContext context) async{
  if (user != null) {
    await     MySharedPreferences.instance.setStringValue("account","email_username");

    await     MySharedPreferences.instance.setStringValue("userId", user.id.toString());
await MySharedPreferences.instance.setStringValue("email", user.email.toString());
await     MySharedPreferences.instance.setStringValue("name", user.name.toString());

loadScreen(context, MyHomePage(title: 0));

  }
}


void signIn(BuildContext context,updateScreen) async {
  await _ensureInitialized();
  final GoogleSignInUserData? newUser =
  await GoogleSignInPlatform.instance.signInSilently();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(newUser!.email),
    duration: Duration(milliseconds: 4000),
  ));
  setUser(newUser,context,updateScreen);
}


void handleSignIn(BuildContext context,updateScreen) async {
  try {
    await _ensureInitialized();
    setUser(await GoogleSignInPlatform.instance.signIn(),context,updateScreen);
  } catch (error) {
    final bool canceled =
        error is PlatformException && error.code == 'sign_in_canceled';
    if (!canceled) {
      print(error);
    }
  }
}

void loadScreen(BuildContext context, Widget screen){
    Navigator.push(context,
    MaterialPageRoute(builder: (_) =>  screen));
}
void handleSignOut(BuildContext context) async {

  String account =   await MySharedPreferences.instance.getStringValue("account");

  if(account == "google") {
    await _ensureInitialized();
    await GoogleSignInPlatform.instance.disconnect();
  }
  await MySharedPreferences.instance.setStringValue("userId", "");
  await MySharedPreferences.instance.setStringValue("email", "");
  await MySharedPreferences.instance.setStringValue("name", "");
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  MyHomePage(title: 0)
      )
  );
}

String baseUrl = "mzalendopk.herokuapp.com";
Future<String> fetchData(String path,Map<String,dynamic> params) async{
String ur = baseUrl + path;
  Uri uri = Uri.https(baseUrl,path,params);

  //Uri.parse(ur);

  Response response = await get(uri);
  return response.body.toString();


}