import 'package:flutter/material.dart';
import 'package:rentalapp/class/uploadArticle.dart';
import 'package:rentalapp/view/articleView.dart';
import 'package:rentalapp/view/messageView.dart';


void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
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
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const UploadFile();
            }));
          });
        },
        child: const Icon(Icons.file_upload_outlined),
      ),

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
              selectedIcon: Icon(Icons.message),
              icon: Icon(Icons.messenger),
              label: "messages"),
          NavigationDestination(
              selectedIcon: Icon(Icons.perm_identity),
              icon: Icon(Icons.person),
              label: "profile"),
        ],
      ),
      body:<Widget> [
        ArticleView(),
        Container(
          color: Colors.green,
        ),
        MessageView(),
        Container(
          color: Colors.pink,
        ),
      ][currentPage]
    );

  }
}
