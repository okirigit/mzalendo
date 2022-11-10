import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polls/widgets/commentbox.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/postmodel.dart';
import '../../models/posts.dart';
import '../../utils/constants.dart';
import '../../widgets/comments.dart';
import '../../widgets/special_icon.dart';

// ignore: must_be_immutable
class PostWidget extends StatelessWidget {
  PostWidget({
    Key? key,
    required this.datamodel,
    required this.index,
  }) : super(key: key);
  PostModel datamodel;
  int index;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0, top: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        datamodel.title.text
                            .minFontSize(13)

                            .color(Colors.black)
                            .maxFontSize(14)
                            .letterSpacing(1)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(1)
                            .fontWeight(FontWeight.w600)
                            .make(),
                        // datamodel.user.bio.text
                        //     .minFontSize(12)
                        //     .maxFontSize(13)
                        //     .color(Colors.blue)
                        //     .make(),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [

                            const SizedBox(
                              width: 2,
                            ),
                            datamodel.uploadTime
                                .toString()
                                .text
                                .letterSpacing(1)
                                .minFontSize(10)
                                .maxFontSize(12)
                                .color(Colors.black)
                                .make(),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(

            height: 0,
          ),
          datamodel.tweetText.isEmpty
              ? Container()
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child:    Text(
              datamodel.tweetText,
              overflow:TextOverflow.ellipsis,
              maxLines: 8,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                height: 1.35,
                fontWeight: FontWeight.w400,

                color: Colors.black,
              ),
            ),
          ),
          datamodel.tweetImage == ''
              ? Container()
              : Image.network(datamodel.tweetImage!),
          const SizedBox(
            child: Divider(
              color: Colors.black38,
            ),
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SpecialIcon(
              val: datamodel.comments.length.toString(),
              iconData: Icons.comment_outlined,
              color: kMainColor,
              doFunction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CommentsPage(post:datamodel)

                  ),
                );
                // Get.toNamed('/commentspage', arguments: index);
              },
            ),
            SpecialIcon(
              val: datamodel.retweets.length.toString(),
              iconData: Icons.repeat,
              color: kmainColor,
              doFunction: () {},
            ),
            SpecialIcon(
              val: datamodel.likes.length.toString(),
              iconData: datamodel.likes.isEmpty
                  ? Icons.favorite_border_outlined
                  : Icons.favorite,
              color: datamodel.likes.isEmpty ? kMainColor : kMainColor,
              doFunction: () {

              },
            ),
            SpecialIcon(
              val: '',
              iconData: Icons.share,
              color: kMainColor,
              doFunction: () {
                Share.share(datamodel.title + " \n"+datamodel.tweetText + "\n Powered by Mzalendo PK ");
              },
            )
          ]),
        ],
      ),
    );
  }
}
