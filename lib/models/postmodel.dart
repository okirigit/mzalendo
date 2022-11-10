import 'dart:io';

import 'package:polls/models/usermodel.dart';


class PostModel {
  String title = '';
  UserModel user = UserModel(
      name: 'Anonymous',
      bio: 'Patriotic',
      profileImage:
          'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80',
      bannerImage:
          'https://c4.wallpaperflare.com/wallpaper/256/820/44/dreams-failure-motivational-inspirational-wallpaper-preview.jpg');
  String tweetText = '';
  String? tweetImage;
  List<String> likes = [];
  List<String> comments = [];
  List<String> retweets = [];
  String? uploadTime;
  String? id;
  String? location;
  String? category;
  String? date;

}
