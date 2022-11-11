import 'dart:io';

import 'package:polls/models/usermodel.dart';


class PostModel {
  String title = '';
  UserModel user = UserModel(
      name: 'Anonymous',
      bio: 'Patriotic',
      profileImage:
          'https://mzalendopk.herokuapp.com/images/logo.png',
      bannerImage:
          'https://c4.wallpaperflare.com/wallpaper/256/820/44/dreams-failure-motivational-inspirational-wallpaper-preview.jpg');
  String tweetText = '';
  String? tweetImage;
  List<dynamic> images = [];
  List<String> likes = [];
  Map<String,dynamic> commentsParent = {};
  List<String> retweets = [];
  List<String> comments = [];

  String? uploadTime;
  String? id;
  String? location;
  String? category;
  String? date;

  PostModel.fromJson(Map json) {
    print(json["Comments"]);

    List<dynamic> ims = json['images'];
    String dd = json['date'].toString().substring(0,10);
    id = json['_id'];
    title = json['category'] ;
    category = json['category'] ;
    tweetText = json['report'];
    date = dd;

    uploadTime= dd;
    location =  title + " in "+json['locationName'];
    tweetImage = ims.isNotEmpty ? json['images'][0] : '';
    images = json['images'];
    commentsParent = json['Comments'];
    if(commentsParent != null ){
      commentsParent.forEach((index,value) {
        comments.add(value['comment']);
      });
    }
    }

  }

