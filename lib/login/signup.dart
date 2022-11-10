import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polls/MySharedPreferences.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import 'package:polls/constants.dart';
import 'package:polls/login/signin.dart';
import 'package:polls/variables.dart';
import 'package:velocity_x/velocity_x.dart';

import '../account.dart';
import '../main.dart';
import '../utils/constants.dart';
import '../utils/fetch.dart';
import '../widgets/checkbox.dart';
import '../widgets/custom_input.dart';
import '../utils/authFunction.dart';
import 'login.dart';
final passController = TextEditingController();

final userController = TextEditingController();


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<SignUp> createState() => _SignUpState();

}
//late bool fetched = false;

class _SignUpState extends State<SignUp> {
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
                  child: 'Create  Account'
                      .text
                      .minFontSize(24)
                      .fontWeight(FontWeight.w600)
                      .maxFontSize(26)
                      .make(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: 'Please fill in your details to get Started'
                      .text
                      .minFontSize(18)
                      .make(),
                ),
                InkWell(
                  onTap: (){
                   // _handleSignIn(context, updateScreen);

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
                        'Register with Google'.text.minFontSize(18).make()
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
                      child: Text("First Name"),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 2.0),
                      child: Text("Last Name"),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(bottom: 2.0),
                      child: Text("Phone Number"),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text("Confirm Password"),
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
                const SizedBox(
                  height: 20,
                ),


                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child:
                  ElevatedButton(

                    onPressed: () async {

                      setState(() {
                        isRunning = true;
                      });
                      String e = emailC.text;
                      String p = passC.text;
                      final queryParameters = {
                        'email': e,
                        'pass': p,
                      };
                      String user = await fetchData("signup",queryParameters);
                      print(user);
                      setState(() {
                        isRunning = false;
                      });

                    },
                    child: Center(

                        child:Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: 'Sign Up'
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
                      'Already have an account?'.text.minFontSize(16).make(),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: (){
                          loadScreen(context,const Login());
                        },
                        child: 'Log In'
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

