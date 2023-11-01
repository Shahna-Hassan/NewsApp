import 'package:newsapi/model/mymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key, required this.newArticle});
  final Article? newArticle;

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(
  elevation: 0,
actions: [
 Icon(Icons.bookmark_add_outlined, color: Colors.black,),
 SizedBox(width: 15,),
    Icon(Icons.share,  color: Colors.black),
    SizedBox(width: 15,),],
  backgroundColor: Colors.white,
  leading: IconButton(onPressed: () {
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back), color: Colors.black,)
),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                
                Image.network(widget.newArticle?.urlToImage??""),
                SizedBox(height: 20),
                HtmlWidget(
                  
                  widget.newArticle?.content??"", )
                
                
                ]),
          ),
        ),
        
      ),
    );
  }
}