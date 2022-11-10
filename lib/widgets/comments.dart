import 'package:flutter/material.dart';
import 'package:polls/models/postmodel.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'commentbox.dart';
import 'inputtext.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key? key,required this.post}) : super(key: key);
final PostModel post;
  @override
  Widget build(BuildContext context) {
   // final myprovider = Provider.of<PostsProvider>(context);
    var list = post.comments;
    final texteditingcontroller = TextEditingController();
    void addcommenttoList() {
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
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return CommentBox(
                    msg: post.comments[index],
                    user: post.user,
                  );
                }),
                itemCount: post.comments.length,
              ),
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
