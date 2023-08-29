

import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

class ArticleView extends StatefulWidget{
  const ArticleView({super.key});

  @override
  State<ArticleView> createState() => _ArticlePage();
  
}

class _ArticlePage extends State<ArticleView>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            customText("Rent", color: Colors.black, size: 25),
            customText("App", color: Colors.blue, size: 30, fontSize: FontStyle.italic)
          ],
        ),
      ),
    );
  }



  
}