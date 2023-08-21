

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

class ArticleView extends StatefulWidget{
  @override
  State<ArticleView> createState() => _ArticlePage();
  
}

class _ArticlePage extends State<ArticleView>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText("RentApp"),
        actions: [
          IconButton(
              onPressed: null,
              icon: customIcon(Icons.search)),
          IconButton(
              onPressed: null,
              icon: customIcon(Icons.account_circle))
        ],
      ),
    );
  }
  
}