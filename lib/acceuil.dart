import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rentalapp/view/article.dart';
import 'package:rentalapp/view/message.dart';
import 'package:rentalapp/view/profit.dart';
import 'package:rentalapp/view/subscribe.dart';


class Home extends StatelessWidget {
  final id;
  const Home({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:MyHomePage(id: id),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final id;
  const MyHomePage({super.key, required this.id});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int currentPage = 0;
  String idUser = "id";
  var currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
       onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
        destinations: const[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined),
              icon: Icon(Icons.home),
              label: "home"),
          NavigationDestination(
            selectedIcon: Icon(Icons.language),
              icon: Icon(Icons.language),
              label: "explore"),
          NavigationDestination(
              selectedIcon: Icon(Icons.question_answer_outlined),
              icon: Icon(Icons.question_answer_sharp),
              label: "messages"),
          NavigationDestination(
              selectedIcon: Icon(Icons.perm_identity),
              icon: Icon(Icons.person),
              label: "me"),
        ],
      ),
      body:<Widget> [
        ArticleView(id: widget.id),
        Subscriber(id: widget.id),
        MessageView(id: widget.id),
         Profit(id: widget.id)
      ][currentPage]
    );

  }
}
