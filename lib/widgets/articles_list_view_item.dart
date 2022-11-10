import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/task.dart';


class ArticlesListViewItem extends StatelessWidget {
  const ArticlesListViewItem(
      {Key? key, required this.data, required this.onPressed})
      : super(key: key);

  final Task data;
  final Function() onPressed;

  final double height = 90;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child:SizedBox(
                      height: height,
                      width: height,
                      child: Image.asset(
                        "assets/images/logo.png",
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,


                        fit: BoxFit.cover,
                      ),
                    )

            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(
                    left: height * 0.15,
                    top: height * 0.06,
                    bottom: height * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 6,
                      child: SizedBox(
                        height: height * 0.85,
                        child: Text(
                          data.title ?? 'no title',
                          maxLines: 2,
                          style: const TextStyle(
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              data.subtitle ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
