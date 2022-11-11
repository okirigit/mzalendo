import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:polls/models/postmodel.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../MySharedPreferences.dart';
import '../utils/fetch.dart';
import '../variables.dart';
import 'commentbox.dart';
import 'inputtext.dart';
class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key,required this.post}) : super(key: key);
  final PostModel post;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<CommentsPage> createState() => CommentsPageState();

}

class CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
   // final myprovider = Provider.of<PostsProvider>(context);
    var list = widget.post.comments;
    final texteditingcontroller = TextEditingController();
    void addcommenttoList() async {
       String id= await MySharedPreferences.instance.getStringValue("userId");
       String name = await MySharedPreferences.instance.getStringValue("name");
      final queryParameters = {
        'questionid': widget.post.id,
        'comment': texteditingcontroller.text,
        "userId":id,
        "name":name
      };
AwesomeDialog( dialogType: DialogType.success, context: context,title: "Success",body: Center(child: const Text("Comment added successfully"),)

).show();
      String user = await fetchData("addComment",queryParameters);
setState(() {
  widget.post.comments.add(texteditingcontroller.text);

});
      print(user.toString());




      //   myprovider.addCommenttoPost(post, texteditingcontroller.text);
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: 'Comments'.text.make(),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child:widget.post.comments.isNotEmpty ?
              ListView.builder(
                itemBuilder: ((context, index) {
                  return CommentBox(
                    msg: widget.post.comments[index],
                    user: widget.post.user,
                  );
                }),
                itemCount:widget.post.comments.length,
              ) : const SizedBox.shrink(),
              //color: Colors.blue,
            ),
            CustomTextInputWidget(
              msgController: texteditingcontroller,
              performFunc: addcommenttoList,
            ),
          ],
        ),
      ),
    );
  }


}
