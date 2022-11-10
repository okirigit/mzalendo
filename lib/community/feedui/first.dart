import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstFeedUI extends StatelessWidget {


   FirstFeedUI({Key? key, String? image, required this.title, required this.views, required this.description,required this.amount,required this.duration,required this.type}) : super(key: key);
  final String title;
  final String description;
  final String amount;
  final String duration;
  final String type;
  final String views;
  late String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 400,
          child: Stack(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.only(top: 48.0, left: 18, right: 18),
                  child: Material(
                    borderRadius: BorderRadius.circular(18.0),
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),

                      child: Image.asset(

                          type == 'Locate' ? "assets/images/back1.jpg" : "assets/images/newback.jpg"),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 38.0, top: 18),
                child: Material(
                  elevation: 7,
                  borderRadius: BorderRadius.circular(140),
                  child: Container(
                      height: 64,
                      width: 64,
                      margin: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 0),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.circular(140)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          type == 'Locate' ? 'assets/images/locateTask.png' :'assets/images/explore.png' ,

                        ),
                      )),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 0.0),
                    child: Center(
                      child: Material(
                        borderRadius: BorderRadius.circular(6),
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          height: 140,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.averiaLibre(
                                        color: Colors.grey[900],
                                        fontSize: 18,

                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 0, left: 20),
                                  child: Text(
                                    description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.lato(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.normal),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4.0, left: 18),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.currency_pound,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    Text(
                                      "Reward of  KES $amount ",
                                      style: GoogleFonts.lato(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, top: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.lock_clock,
                                      color: Colors.black45,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 2.0),
                                      child: Text(
                                        "Task duration $duration",
                                        style: GoogleFonts.averageSans(
                                            color: Colors.grey[700],
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 153,
                    right: 35, //give the values according to your requirement
                    child: Material(
                        color: Colors.orange,
                        elevation: 10,
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Icon(
                            Icons.remove_red_eye,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2, left: 28.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.asset(
                      'assets/images/like.png',
                      height: 35,
                    ),
                  ),
                  // Text(
                  //   '45',
                  //   style: GoogleFonts.averageSans(
                  //       color: Colors.grey[700],
                  //       fontSize: 22,
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.normal),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 22.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 1.0),
                    child: Icon(Icons.remove_red_eye_rounded)
                  ),
                  Text(
                    views == "0" ? 'Be the first to participate' : '$views have participated in this event',
                    style: GoogleFonts.averageSans(
                        color: Colors.grey[700],
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
