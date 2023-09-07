
import 'package:flutter/material.dart';
import 'package:rentalapp/class/allRoutes.dart';

void main(){
  runApp(const RouteApp());
}


class RouteApp extends StatelessWidget{
  const RouteApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Go Router",
      routerConfig: router,
    );
  }


}