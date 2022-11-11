import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../models/usermodel.dart';
import '../utils/constants.dart';

class CommentBox extends StatelessWidget {
  const CommentBox({Key? key, required this.msg, required this.user})
      : super(key: key);
  final String msg;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: ktxtwhiteColor,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.profileImage),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: user.name.text
                            .color(ktxtwhiteColor)
                            .minFontSize(15)
                            .fontWeight(FontWeight.w600)
                            .make())
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    FittedBox(
                      child:msg != null ? msg.text
                          .align(TextAlign.start)
                          .color(Colors.white)
                          .fontWeight(FontWeight.w400)
                          .minFontSize(14)
                          .maxFontSize(16)
                          .make() : SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            )),
        const Spacer(),
      ],
    );
  }
}
