import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/profit/articleCollection.dart';
import 'package:rentalapp/profit/person.dart';

import '../profit/uploadArticle.dart';

class Profit extends StatelessWidget{
  const Profit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProfitPage(),
    );
  }

}

class ProfitPage extends StatefulWidget{
  const ProfitPage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfitPage();
}

class _ProfitPage extends State<ProfitPage>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
        length: 2,
        child: Scaffold(
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

          appBar: AppBar(
            title: Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                customText("Work", color: Colors.black, size: 29),
                customText("Space", color: Colors.blue, size: 25, fontSize: FontStyle.italic)
              ],
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: customIcon(Icons.person, colors: Colors.black38),
                ),
                Tab(
                  icon: customIcon(Icons.cabin_sharp, colors: Colors.black38),
                )
              ],
            ),
          ),
          body:  const TabBarView(
              children: [
                Person(),
                ViewArticle()
              ]),
        )
    );
  }


}



