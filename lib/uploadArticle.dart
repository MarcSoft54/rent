

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class/function.dart';

class UploadFile extends StatefulWidget{
  const UploadFile({super.key});


  @override
  State<UploadFile> createState()=> _UploadFile();
}

class _UploadFile extends State<UploadFile>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: customText("upload you home", size: 20),
      ),
      body: GestureDetector(
        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 12,

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
