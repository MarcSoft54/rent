
import 'package:flutter/material.dart';
import 'package:rentalapp/view/article.dart';
import 'package:rentalapp/view/message.dart';
import 'package:rentalapp/view/profit.dart';
import 'package:rentalapp/view/explore.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  String keyUser = "userId";

  int currentPage = 0;
  String currentUser ='';

  @override
  void initState() {
    super.initState();
    setState(() {
      addSave(widget.id);
      saveId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: context.theme.primaryColorLight,
          onDestinationSelected: (int index){
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.home_outlined),
                icon: Icon(Icons.home),
                label: "home"),
            NavigationDestination(
                selectedIcon: Icon(Icons.language_rounded),
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
          ArticleView(id: currentUser),
          Explore(id: currentUser),
          MessageView(id: currentUser),
          Profit(id: currentUser)
        ][currentPage]
    );

  }

  void saveId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? current = preferences.getString(keyUser);
    if(current != null && current != ":id"){
      setState(() {
        currentUser = current;
      });
    }
  }
  void addSave(String str)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(str != ":id"){
      currentUser = str;
      await preferences.setString(keyUser, currentUser);
    }
  }

}
