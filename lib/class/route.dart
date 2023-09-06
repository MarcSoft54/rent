
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalapp/acceuil.dart';
import 'package:rentalapp/initial.dart';
import 'package:rentalapp/login.dart';
import 'package:rentalapp/main.dart';
import 'package:rentalapp/profit/editProfile.dart';
import 'package:rentalapp/profit/uploadArticle.dart';
import 'package:rentalapp/signIn.dart';
import 'package:rentalapp/view/profit.dart';

void main(){
  runApp(RouteApp());
}


class RouteApp extends StatelessWidget{
  RouteApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Go Router",
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    // initialLocation: '/first',
      routes: [
        GoRoute(
            path: "/",
            builder: ((context, state)=> const Home()),
        routes: [
          GoRoute(
              path: "profit/:id",
              builder: ((context, state)=> Profit(
                id: state.pathParameters["id"],
              ))),
          GoRoute(
              path: "login",
              builder: ((context, state)=>const Log())),
          GoRoute(
              path: "signIn",
              builder: ((context, state)=> Sign())),
          GoRoute(
              path: "upload/:id",
              builder: ((context, state)=> UploadFile(
                id: state.pathParameters["id"],
              ))
          ),
          GoRoute(
              path: "first",
              builder: ((context, state)=> const MyApp())),
          GoRoute(
              path: "start",
              builder: ((context, state)=> const Init())),
          GoRoute(
              path: "EditProfil/:id",
            builder: ((context, state)=> EditProfil(
                id: state.pathParameters["id"]))
          )
        ]
        ),

      ]);
}