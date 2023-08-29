import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

class ViewArticle extends StatelessWidget{
  const ViewArticle({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: _ViewArticle(),
    );
  }

}

class _ViewArticle extends StatefulWidget{

  @override
  State<_ViewArticle> createState()=>_View();
}

class _View extends State<_ViewArticle>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: customText("Empty", size: 20),
      )
    );
  }

}