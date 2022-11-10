import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurveyTask extends StatelessWidget {


  const SurveyTask({required this.title, required this.views, required this.description,required this.amount,required this.duration,required this.type});
  final String title;
  final String description;
  final String amount;
  final String duration;
  final String type;
  final String views;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 5.0, right: 5, top: 14, bottom: 5),
          child: Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            elevation: 2,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: Image.asset(

                             'assets/images/explore_bg.jpg' ,
                                fit: BoxFit.fitWidth),
                          )),
                      Positioned(
                        bottom: 100,
                        right:
                        210, //give the values according to your requirement
                        child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(100),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/surv_icon.png'),
                              ),
                            )),
                      ),
                      Positioned(
                          top: 130,
                          left: 25,
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.orange[700],
                                fontSize: 13,
                                letterSpacing: 1,
                                fontWeight: FontWeight.normal),
                          )),
                      Positioned(
                          top: 150,
                          left: 25,
                          right: 5,
                          child: Text(
                            description,

                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                color: Colors.black87,
                                fontSize: 14,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          )),
                      Positioned(
                        top: 160,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25, left: 26.0, bottom: 5),
                          child: Row(
                            children: [
                              Stack(children: [
                                // Material(
                                //   elevation: 0,
                                //   borderRadius: BorderRadius.circular(100),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(top: 2.0),
                                //     child: CircleAvatar(
                                //         radius: 10,
                                //         backgroundImage: NetworkImage(
                                //           'https://miro.medium.com/max/10000/0*wZAcNrIWFFjuJA78',
                                //         )),
                                //   ),
                                // ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0.0,
                                    top: 0.5,
                                  ),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                          radius: 9,
                                          backgroundImage: NetworkImage(
                                            'https://i.insider.com/5c9a115d8e436a63e42c2883?width=600&format=jpeg&auto=webp',
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  child: Material(
                                    elevation: 4,
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(2.0),
                                      child: CircleAvatar(
                                          radius: 9,
                                          backgroundImage: NetworkImage(
                                            'https://play-images-prod-cms.tech.tvnz.co.nz/api/v1/web/image/content/dam/images/entertainment/shows/p/person-of-interest/personofinterest_coverimg.png.2017-03-08T11:21:33+13:00.jpg?width=960&height=540',
                                          )),
                                    ),
                                  ),
                                ),
                              ]),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 10),
                                  child: Text(
                                    views == "0" ? 'Be the first to participate' : '$views have participated in this event',
                                    style: GoogleFonts.lato(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
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
    );
  }
}
