import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/json/user.dart';

class SubArticle extends StatelessWidget{

  const SubArticle(this.user, {super.key});
final User user;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: customText(user.username),
      ),
    );
  }
}
