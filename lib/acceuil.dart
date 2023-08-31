import 'package:flutter/material.dart';
import 'package:rentalapp/view/article.dart';
import 'package:rentalapp/view/message.dart';
import 'package:rentalapp/view/profit.dart';
import 'package:rentalapp/view/subscribe.dart';


// void main() {
//   runApp(const Home());
// }

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "RentApp"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  int currentPage = 0;
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
            selectedIcon: Icon(Icons.groups),
              icon: Icon(Icons.group),
              label: "subscribe"),
          NavigationDestination(
              selectedIcon: Icon(Icons.question_answer_outlined),
              icon: Icon(Icons.question_answer_sharp),
              label: "messages"),
          NavigationDestination(
              selectedIcon: Icon(Icons.perm_identity),
              icon: Icon(Icons.person),
              label: "profile"),
        ],
      ),
      body:<Widget> [
        const ArticleView(),
        const Subscriber(),
        const MessageView(),
        const Profit()
      ][currentPage]
    );

  }
}
