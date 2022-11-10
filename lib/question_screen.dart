import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polls/models/question.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polls/variables.dart';
import 'firebase_options.dart';
import 'main.dart';

bool isFetched = false;

List<Question> qs = [];
List<dynamic> answers_ = [];
class QuestionScreen extends StatefulWidget {
   QuestionScreen({Key? key, required this.title,required this.url,required this.answers__}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String url;
  final Map<String, dynamic> answers__;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();

}

class _QuestionScreenState extends State<QuestionScreen> {
  int _counter = 0;
  int _selectedIndex = 0;
String step_error = '';
bool isFetched_ = false;
bool isFetched = false;

Widget placeholder_ = Image.asset('assets/pick_img.png');
  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget main = Center(child: CircularProgressIndicator(color: Colors.black,),);

  void _incrementCounter() {
    setState(() {


      _counter++;
    });
  }

  void updateStepError(String value) {
    setState(() {
step_error = value;
      // qs[pos].answer = value;
    });
  }
  void setQsState(int pos,String value) {
    setState(() {

      // qs[pos].answer = value;
    });
  }
  void updateImage(String image) {

    setState(() {
placeholder_ = Image.file(File(image));
      // qs[pos].answer = value;
    });
  }

  void updateImage_(Widget image) {

    setState(() {
      placeholder_ = image;
      // qs[pos].answer = value;
    });
  }


  void getQuestions (Widget widg){
    setState(() {
      main = widg;
    });
  }
  var client = Client();
  Future  getData(id,url) async{
    Uri ur = Uri.parse("https://data-pal.herokuapp.com/fetchForm?id="+id);
    const url_ = "mongodb+srv://mzalendopk:mzalendo2022@cluster0.u3y6lwf.mongodb.net/test";
    List<dynamic> questionaire__ = [];

    if(isFetched == false ) {

      isFetched = true;

      await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);




      Response response = await get(ur);
      String content = response.body;
      print(jsonDecode(response.body.toString()));

      List<dynamic> questionaire_ = jsonDecode(response.body.toString()) as List;
      for (var i = 0; i < questionaire_.length; i++) {
        //print(i);
        questionaire__.add(questionaire_[i]);
      }
      if(url != "start"){
       // List<dynamic> myanss = data['Answers'][userId] ;
     //   print(myanss);
      //  answers_ = myanss;
      }
      client.close();
      return questionaire__;
      return jsonDecode(response.body.toString());

    }
  }

  void showDialog_(context,message){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Ooops!',
      desc: "Please fill out this field.",
      dismissOnTouchOutside: true,
      btnCancelOnPress: () {

      },
      btnCancelText: "Dismiss",

      btnOkColor: Colors.orange,

    ).show();
  }
  @override
  Widget build(BuildContext context) {
    //answers_ = widget.answers__;
    startFire();
    List<Widget> questions = [];
    List<String> headers = [];
    List<dynamic> _steps = [];
    List<CoolStep> steps = [];
    List<dynamic> questionaire = [];
    if(isFetched == false){
    getData(widget.title,widget.url).then((value) {
      questionaire = value;
      isFetched = true;
      Widget field = SizedBox.shrink();
      for (var i = 0; i < questionaire.length; i++) {
        var type = questionaire[i]["type"];
        String title = questionaire[i]['label'];
        String placeholder = questionaire[i]['placeholder'] ?? "Write your answer here";

        switch (type) {
          case 'text':
          // myQz.title = "sdfsf";
            final TextEditingController myController = new TextEditingController();
            //myController.text = widget.answers__ == {} ? "" : widget.answers__[i]['answer']  ;
            Question qx = Question(question: title,
                id: questionaire[i]['name'],
                controller: myController);
            qs.add(qx);
            int index = qs.indexWhere((element) =>
            element.id == questionaire[i]['name']);

            Widget title_ = Align(
              alignment: Alignment.centerLeft,
              child: Container(

                child: Text(
                  title, style: GoogleFonts.lato(fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                ),
              ),
            );
            questions.add(title_);
            field = Column(children: [
              title_,
              SizedBox(height: 15,),
              SizedBox(height: 350,

                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  style: GoogleFonts.lato(color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,),
                    decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: GoogleFonts.lato(color: Colors.red),
                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),


                  ),
                  controller: qs[index].controller,
                ),)


            ]);
            questions.add(field);


            // do something


            break;

          case 'header':
            headers.add(title);
            // print(i);
            Question qx = Question(
                question: title, id: "head", answer: "head");
            qs.add(qx);
            if (i != 0) {
              String title_ = headers[headers.length - 2];

              // print(headers.length.toString() + title_);
              List<Widget> stepQs = questions;


              questions = [];
            }

            break;
          case "file":
            Question qx = Question(question: title,
              id: questionaire[i]['name'],type: "image",answer: ""
            );
            qs.add(qx);
            int index = qs.indexWhere((element) =>
            element.id == questionaire[i]['name']);
            Widget title_ = Align(
              alignment: Alignment.centerLeft,
              child: Container(

                child: Text(
                  title, style: GoogleFonts.lato(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
                ),
              ),
            );
            questions.add(title_);

            field = Column(children: [
              title_,
              SizedBox(height: 15,),
              SizedBox(height: 350,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    cameraStart(questionaire[i]['className'], updateImage,index);
                  },
                  child: placeholder_,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only( left: 10, right:10,top:10,bottom: 10)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text("Upload Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                onPressed: (){
                  uploadImage(index,widget.title,updateImage_);
                },
              ),
            ]
            );
            break;
          case 'checkbox-group':
            bool value_ = false;
            Question qx = Question(
                question: title, id: questionaire[i]['name'], answer: value_);
            qs.add(qx);
            int index = qs.indexWhere((element) =>
            element.id == questionaire[i]['name']);
            field = Checkbox(
              value: qs[index].answer == "true" ? true : false,
              onChanged: (valuex) {
                qs[index].answer = valuex.toString();
                print(qs[index].question);
                setQsState(index, valuex.toString());
              },
            );
            questions.add(field);
            break;
          case 'radio-group':
            List<dynamic> options = questionaire[i]['values'];
            List <String> _status = [];
            List <dynamic> rops = [];
            for (var i = 0; i < options.length; i++) {
              // Map<Object, dynamic> option = options[i];
              _status.add(options[i]['value']);
            }
            String value_ = _status[1];

            Question qx = Question(
                question: title, id: questionaire[i]['name'], answer: value_,type: "radio");
            qs.add(qx);
            int index = qs.indexWhere((element) =>
            element.id == questionaire[i]['name']);

            field = RadioGroup<String>.builder(

              groupValue: widget.url == 'start' ? value_ : "" ,

              onChanged: (value) {
//to Add to list
                print(value);
                qs[index].answer = value.toString();

                Question question = Question(question: qs[index].question, id: qs[index].id,answer: qs[index].answer);

                postData(widget.title,question,index);

               // setQsState(index, value.toString());
              },
              items: _status,

              spacebetween: 30,
              activeColor: Colors.black,

              textStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.black),

              itemBuilder: (item) =>
                  RadioButtonBuilder(


                    item,
                  ),
            );
            questions.add(field);
            break;
        }

        if (type != 'header') {
          steps.add(CoolStep(
              title: "Question " + (i + 1).toString(),
              subtitle: questionaire[i]['required'] == "true"
                  ? "Required"
                  : "(Optional)",

              content: Column(
                children: [field,
                  Text(step_error, style: GoogleFonts.montserrat(
                      color: Colors.red, fontWeight: FontWeight.bold),)
                ],
              ),

              validation: () {
               // print(type);
                int index = qs.indexWhere((element) =>
                element.id == questionaire[i]['name']);
                switch (type){

                    case 'image':
                      if(qs[index].answer != ""){
                     //   postData("/data/Questions/"+widget.title+"/Answers/"+email+'/'+index.toString(),qs[index]);

                      }else{
                      //  updateStepError("please upload your image first");

showDialog_(context,"Please upload the image first");
                        return "error";
                      }
                      break;
                    case 'text':
                      
                      if (qs[index].controller?.text == "") {
                       // postData("/data/Questions/"+widget.title+"/Answers/"+userId+'/'+index.toString(),question);

showDialog_(context,"Please fill out this field");

                        return "error";
                      } else {
                        print(qs[index].controller?.text);

                        qs[index].answer = qs[index].controller?.text;
                        Question question = Question(question: qs[index].question, id: qs[index].id,answer: qs[index].answer);
                      //  print("ddddddddddddddd");


                        postData(widget.title,question,index);
                       // updateStepError("");

                      }
                      break;
                    case 'radio-group':
                      print('radio');
                      break;


                  }


              }

          ));
        }
      }
      String? form = widget.url;

      Widget fwidget = CoolStepper(
          onCompleted: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Submit Task',
              desc: "By Pressing on Submit,you agree and confirm that the information provided is correct to the best of your knowledge, your answers will be submitted for review to admin. Approval status willbe updated in your wallet section",
              dismissOnTouchOutside: false,
              btnCancelOnPress: () {

              },
              btnCancelText: "Cancel",
              btnOkText: "Submit",
              btnOkColor: Colors.orange,
              btnOkOnPress: () {

                print(userId);

                addQuestion(userId,widget.title,context);
},
            ).show();



            // print(json.decode(qs.toString()));
          },

          config: const CoolStepperConfig(
              backText: "Previous",

              nextText: "Next",
              stepText: "Question",
              ofText: "OF"),
          steps: steps
      );
      isFetched = true;

      setState(() {
        main = fwidget;
        isFetched_ == true;
      });
    });
  }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Task"),
      ),
      body: main,

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
bool fetched = false;
Future  fetchNewert(setQsState,getQuestions,id) async {
  if(1 == 1) {


    }
  }


void startFire() async {

}
void postData(String id,Question obj,int index) async{

  final objx = {
    "index":index,
    "answer":obj.answer
  };
  final queryParameters = {
    'question': objx,
    'user': userId,
    "questionId":id

  };
  print(queryParameters);
  //final uri = Uri.parse('$baseUrl/saveAnswer').replace(queryParameters: queryParameters);
  //String queryString = Uri.parse(queryParameters.toString()).query;
String answ = obj.answer;
  var requestUrl = '$baseUrl/saveAnswer?index=$index&answer=$answ&userId=$userId&questionid=$id';
  Response response =  await get(Uri.parse(requestUrl));
  String content = response.body;




}
void addQuestion (String path,String id,BuildContext context) async {
  Response response = await get(Uri.parse('$baseUrl/submitQuestion?userId=$userId&questionid=$id'));
  String content = response.body;
  Navigator.pop(context);

}


final ImagePicker _picker = ImagePicker();

void cameraStart(String type,updateImage,int index) async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  if(photo != null){

    print(photo.path);

    XFile xx = XFile(photo.path);
    path_ = photo.path;
    //Image(image: await xFileToImage(xx));
    updateImage(photo.path,);



  }else{
    print("not found");
  }
 // print(photo?.path);

}
Future<ImageProvider<Object>> xFileToImage(XFile xFile) async {
  final Uint8List bytes = await xFile.readAsBytes();

  return Image.memory(bytes).image;
}
String path_ = '';

void uploadImage(int index,String quid, updateImage_) async {
Widget wait = Center(child: CircularProgressIndicator(color: Colors.black,),);
  updateImage_(wait);
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref('/DataAnswers').child('/Question'+index.toString());
  File file = File(path_);
  await ref.putFile(file);
  String imageUrl = await ref.getDownloadURL();
  print(imageUrl);
  final ref_ = FirebaseDatabase.instance.ref('/data/Questions/'+quid+'/Answers/'+userId+'/'+index.toString());
ref_.set({"answer":imageUrl});
  qs[index].answer = imageUrl;
  wait = Image.network(imageUrl);
updateImage_(wait);

}