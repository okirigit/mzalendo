import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polls/MySharedPreferences.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import 'package:polls/constants.dart';
import 'package:polls/login/signin.dart';
import 'package:polls/variables.dart';

import '../account.dart';
import '../main.dart';

final passController = TextEditingController();

final userController = TextEditingController();

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
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<Login> createState() => _LoginState();

}
//late bool fetched = false;

class _LoginState extends State<Login> {
Widget screen_ = Text('Login to DataPal');
void updateScreen(Widget screen){
  setState(() {
    screen_ = const MyHomePage(title: 0);
  });
}
@override
void initState(){
  super.initState();

  setState(() {
    if(userId != ""){
      screen_ = const MyHomePage(title: 0);
    }else {
      screen_ = GestureDetector(
          onTap: () {
            //  SystemSound.play(SystemSoundType.click);

          },
          child: Center(child: ElevatedButton(
            onPressed: () {
              _handleSignIn(context, updateScreen);
            }, child: SignInPage(),

          ),)

      );
    }
  });
}
  @override
  Widget build(BuildContext context) {

    //_handleSignIn(context);

    return Scaffold(


      body:  screen_

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}


void _setUser(GoogleSignInUserData? user, BuildContext context, updateScreen) {
  _currentUser = user;
  if (user != null) {

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


Future<void> _signIn(BuildContext context,updateScreen) async {
  await _ensureInitialized();
  final GoogleSignInUserData? newUser =
  await GoogleSignInPlatform.instance.signInSilently();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(newUser!.email),
    duration: Duration(milliseconds: 4000),
  ));
  _setUser(newUser,context,updateScreen);
}


Future<void> _handleSignIn(BuildContext context,updateScreen) async {
  try {
    await _ensureInitialized();
    _setUser(await GoogleSignInPlatform.instance.signIn(),context,updateScreen);
  } catch (error) {
    final bool canceled =
        error is PlatformException && error.code == 'sign_in_canceled';
    if (!canceled) {
      print(error);
    }
  }
}


Future<void> _handleSignOut(BuildContext context) async {
  await _ensureInitialized();
  await GoogleSignInPlatform.instance.disconnect();

  await MySharedPreferences.instance.setStringValue("userId", "");
  await MySharedPreferences.instance.setStringValue("email", "");
  await MySharedPreferences.instance.setStringValue("name", "");
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>  Login()
      )
  );
}

