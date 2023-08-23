import 'package:flutter/material.dart';

class Person extends StatelessWidget{
  const Person({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: const ProfitPage(),
    );
  }
}


class ProfitPage extends StatefulWidget{
  const ProfitPage({super.key});


  @override
  State<ProfitPage> createState()=> _ProfitPage();

}

class _ProfitPage extends State<ProfitPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(

        child: SingleChildScrollView(

        ),
      ),
    );
  }



}