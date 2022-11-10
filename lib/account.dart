

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls/variables.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import 'MySharedPreferences.dart';
import 'login/login.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  String apiResponsne = '';

  bool _notifications = true;

  void refresh(String value) => setState(() {
    apiResponsne = value;
  });



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

    return Scaffold(


      body:
      SettingsList(

        sections: [




          SettingsSection(
            title: 'Hello '+email,
            titleTextStyle: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),
            titlePadding: EdgeInsets.only( left: 10, right:10,top:10,bottom: 10),

            titleWidget: Container(
              height: 50,
              decoration: new BoxDecoration(
                  color: Colors.red
              ),

            ),

            tiles: [

              SettingsTile(
                title: 'Help Center',
                subtitle: 'Ask for help',
                leading: const Icon(Icons.help,color: Colors.black),

                onPressed: (context) {

                },
              ),

              SettingsTile(
                title: 'Community Guidelines',
                subtitle: 'FAQs and how to answer questions',
                leading: Icon(Icons.book,color: Colors.black),

                onPressed: (context) {

                },


              ),
              SettingsTile(
                onPressed: (context) {

                },
                title: 'Contact Us',
                subtitle: 'Get in touch with our personel. Available 24/7',
                leading: Icon(Icons.contact_mail,color: Colors.black),



              ),
            ],
          ),
          SettingsSection(
            title: '',
            tiles: [




              SettingsTile.switchTile(
                title: 'Enable Notifications & Newsletter',
                enabled: notificationsEnabled,
                leading: const Icon(Icons.notifications_active,color: Colors.black,),
                switchValue: _notifications,
                switchActiveColor: Colors.black,


                onToggle: (value) {


                  setState(() {
                    _notifications = value;
                  });
                  //   MySharedPreferences.instance.setBool("notification", value);


                },
              ),
            ],
          ),
          SettingsSection(
            title: ' ',
            tiles: [
              SettingsTile(
                  title: 'Terms and Conditions', leading: Icon(Icons.description,color: Colors.black)),
              SettingsTile(
                  onPressed: (context) {
                    _handleSignOut(context);
                  },
                  title: 'Logout', leading: Icon(Icons.logout,color: Colors.black)),

            ],

          ),
          CustomSection(
            child: Column(
              children: [

                const Text(
                  'All Rights Reserved. DataPal 2022',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
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
