import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


Text customText(String data,
    {color = Colors.black,
      double size = 15,
      fontSize = FontStyle.normal,
      fontWeight = FontWeight.normal}) {
  return Text(data,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: fontSize,
          fontWeight: fontWeight));
}


Padding padding(
    {double left = 0,
      double right = 0,
      double top = 0.0,
      double bottom = 0}) {
  return Padding(
      padding: EdgeInsets.only(
          left: left, right: right, top: top, bottom: bottom));
}



bool checkEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}


Icon customIcon(IconData iconData, {colors = Colors.black, size = 30.0}){
  return Icon(
   iconData,
    size: size,
    color: colors,
  );
}

Widget buildImage(String urlImage, int index){
  return Card(
    elevation: 20,
    child: Image.file(File(urlImage), fit: BoxFit.fill,)
  );
}