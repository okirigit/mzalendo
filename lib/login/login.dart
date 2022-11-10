import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polls/MySharedPreferences.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:polls/login/signup.dart';

import 'package:velocity_x/velocity_x.dart';

import '../main.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import '../utils/fetch.dart';
import '../utils/authFunction.dart' as myAuth;
import '../widgets/checkbox.dart';

final passController = TextEditingController();

final userController = TextEditingController();

Future<void>? _initialization;

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


class _LoginState extends State<Login> {
Widget screen_ = Text('Login to DataPal');
void updateScreen(Widget screen){
  setState(() {
    screen_ = const MyHomePage(title: 0);
  });
}
@override
void initState(){

}

TextEditingController emailC = TextEditingController();
TextEditingController passC = TextEditingController();
bool isRunning = false;
  @override
  Widget build(BuildContext context) {

    //_handleSignIn(context);

    return Scaffold(


      body: isRunning == false ?
      Container(

        padding: const EdgeInsets.symmetric(horizontal: 25),

        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: kMainColor,
                scale: 3.5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: 'Log in to your Account'
                    .text
                    .minFontSize(24)
                    .fontWeight(FontWeight.w600)
                    .maxFontSize(26)
                    .make(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: 'Welcome back, please enter your details'
                    .text
                    .minFontSize(18)
                    .make(),
              ),
              InkWell(
                onTap: (){

                 handleSignIn(context, updateScreen);

                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: kMainColor,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/search.png',
                        scale: 20,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      'Continue with Google'.text.minFontSize(18).make()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black54,
                        //thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: 'OR'.text.make(),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black54,
                        //thickness: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text("Email Address"),
                  ),
                  TextFormField(
                    controller: emailC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text("Password"),
                  ),
                  TextFormField(
                    controller: passC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CheckBoxx(),
                        'Remember Me'.text.make(),
                      ],
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: 'Forgot Password?'
                            .text
                            .fontWeight(FontWeight.w600)
                            .make(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue
                ),
                child:
                ElevatedButton(

                  onPressed: () async {

                    setState(() {
                   //   isRunning = true;
                    });
                    String e = emailC.text;
                    String p = passC.text;

                    final queryParameters = {
                      'email': e,
                      'pass': p,
                    };
                    String user = await fetchData("mobileSignIn",queryParameters);
                    UserObj profile  =  UserObj.fromJson(jsonDecode(user));


                    initUser(profile,context);
                    setState(() {
                      isRunning = false;
                    });


                  },
                  child: Center(

                      child:Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: 'Log in'
                            .text
                            .minFontSize(18)
                            .fontWeight(FontWeight.w600)
                            .make(),
                      )
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    'Don\'t have an account?'.text.minFontSize(16).make(),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (){
                        loadScreen(context,const SignUp());
                      },
                      child: 'Sign Up'
                          .text
                          .fontWeight(FontWeight.w500)
                          .minFontSize(16)
                          .color(
                        const Color.fromARGB(255, 8, 12, 236),
                      )
                          .make(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )

          :

      const Center(child: CircularProgressIndicator(color: Colors.blue,))

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}

