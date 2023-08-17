import 'package:flutter/material.dart';
import 'package:rentalapp/uploadArticle.dart';


void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'RentApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
              return UploadFile();
            }));
          });
        },
        child: Icon(Icons.file_upload_outlined),
      ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          Icon(Icons.home),
          Icon(Icons.group),
          Icon(Icons.message),
          Icon(Icons.person)
        ],

      ),
    );

  }
}
