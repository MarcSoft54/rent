import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

import '../json/user.dart';

class ViewArticle extends StatefulWidget{
  const ViewArticle(this.user, {super.key});

  final User user;


  @override
  State<ViewArticle> createState() => _ViewPage();
}

class _ViewPage extends State<ViewArticle>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: customText(widget.user.username),
      ),
    );
  }
}