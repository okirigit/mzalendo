import 'package:flutter/material.dart';

import '../models/postmodel.dart';
import 'article_view.dart';

class ArticlePage extends StatelessWidget {
   ArticlePage({Key? key, required this.data}) : super(key: key);
PostModel data;
  static String get routeName => '/article';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(

          backgroundColor: theme.backgroundColor,
          body:  Padding(
            padding: EdgeInsets.all(0),
            child:  ArticleView(data:data),
          ),
        ),
      ),
    );
  }
}
