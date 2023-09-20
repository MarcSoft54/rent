import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/main.dart';
import 'package:rentalapp/view/profit.dart';

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
    Color colorDark = context.theme.primaryColorDark;
    Color colorLight = context.theme.primaryColorLight;
    return Scaffold(
      backgroundColor: colorLight,
      body: Center(
        child: OpenContainer(
                closedBuilder:(_, openContainer){
                  return Container(
                    height: 80,
                    width: 150,
                    child: Center(
                      child: Text(
                          "Welcome",
                        style: context.theme.textTheme.headlineLarge,
                      ),
                    ),
                  );
                },
                openColor: context.theme.primaryColorDark.withOpacity(.5),
                closedElevation: 20,
                closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                transitionDuration: const Duration(milliseconds: 700),
                openBuilder:(_, closeContainer){
                  return SecondPage() ; ///// next page here ...
                }
            )
      ),
    );
  }
}

class SecondPage extends StatefulWidget{
  const SecondPage({super.key});

  @override
  _SecondPageState createState()=> _SecondPageState();
}
class _SecondPageState extends State<SecondPage>{

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 400),(){
      setState(() {
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 400),(){
      setState(() {
        _b = true;
      });
    });
    Timer(const Duration(milliseconds: 1300),(){
      setState(() {
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), (){
      setState(() {
        _e = true;
      });
    });
    Timer(const Duration(milliseconds: 3400),(){
      setState(() {
        _d = true;
      });
    });
    Timer(const Duration(milliseconds: 3850),(){
      setState(() {
        Navigator.of(context).pushReplacement(
          TransitionPage(
              route: const MyApp()
          )
        );
        // my home page
      });
    });
  }
  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    Color colorDark = context.theme.primaryColorDark;
    Color colorLight = context.theme.primaryColorLight;
    return Scaffold(
      backgroundColor: colorLight,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(duration: Duration(
                milliseconds: _d? 900: 2500
            ),
              curve: _d? Curves.fastLinearToSlowEaseIn: Curves.elasticOut ,
              height: _d? 0: _a? _h/2 : 20,
              width: 20,
            ),
            AnimatedContainer(duration: Duration(
                seconds: _d? 1: _c? 2:0
            ),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d? _h: _c? 80:20,
              width: _d? _w:_c?200:20,
              decoration: BoxDecoration(
                  color: _b? colorDark.withOpacity(.9):colorLight,
                  borderRadius:_d?BorderRadius.only():BorderRadius.circular(30)),
              child: Center(
                  child: _e?AnimatedTextKit(
                      totalRepeatCount:1,
                      animatedTexts:[
                        FadeAnimatedText("RentAPP",
                            textStyle: context.theme.textTheme.headlineLarge,
                            duration:const Duration(milliseconds: 1700)
                        )
                      ]
                  ):const SizedBox()
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransitionPage extends PageRouteBuilder{
  var page;
  var route;

  TransitionPage({this.page, this.route})
      :super(
      pageBuilder:(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondAnimation,
      ) => page,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child) => FadeTransition(
        opacity: animation,
        child: route,
      )
  );
}