import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

class Init extends StatelessWidget{
  const Init({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true
      ),
      home: _Init(),
    );
  }
}

class _Init extends StatefulWidget{
  @override
  State<_Init> createState() => InitPage();
}

class InitPage extends State<_Init>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.greenAccent,
            ]
          )
        ),
        child: Column(
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: 100,
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.red,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customIcon(Icons.home_work_outlined),
                      padding(left: 5),
                      customText("@Marc Tech")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}