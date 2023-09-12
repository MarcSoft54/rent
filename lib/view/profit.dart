
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/acceuil.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/class/http/userHttp.dart';



class Profit extends StatelessWidget{
  final id;
  const Profit({super.key, required this.id});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ProfitPage(id: id),
    );
  }

}

extension BuildContextExtenssions on BuildContext {
  ThemeData get theme => Theme.of(this);
}

class ProfitPage extends StatefulWidget{
  final id;
   const ProfitPage({super.key, required this.id});
  @override
  State<StatefulWidget> createState() => _ProfitPage();
}

class _ProfitPage extends State<ProfitPage>{

  Dio dio = Dio();

  var userJson;
  var user;
  String profitPath = '';

  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    log("Profile : ${widget.id}");
    userService.getOneUser(widget.id).then((value){
          setState(() {
            user = value;
            log("user $user");
          });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile", style: Theme.of(context).textTheme.headlineLarge,),
      ),

      body: GestureDetector(
        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 25),
            child: user == null?
            connectionSession() :
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120, height: 120,
                        child: ClipRRect(borderRadius: BorderRadius.circular(100),
                            child : (user.userPicture == '')
                                ?const Image(
                              image: AssetImage("images/account-2.png"),)
                                :Image(
                              image: FileImage(File(user.userPicture)),fit: BoxFit.cover,
                            )
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child:PencilModify(
                            icon: LineAwesomeIcons.alternate_pencil,
                            onPress: (){
                              profitMessage(context);
                            },
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(user.username,
                    style: Theme.of(context).textTheme.titleLarge,),
                  Text(user.email,
                    style: Theme.of(context).textTheme.titleLarge,
                    textScaleFactor: .7,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: (){
                        GoRouter.of(context).go("/edit_profile/${user.id}");
                      },
                      style: customStyleButton(),
                      child: Text("Edit Profile",
                        style: Theme.of(context).textTheme.titleLarge,
                        textScaleFactor: .9,),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Divider(),
                  const SizedBox(height: 20),
                  ProfileSetting(
                    title: "Post a house",
                    icon: LineAwesomeIcons.home,
                    onPress: (){
                      context.go("/upload/${user.id}");
                    },),
                  ProfileSetting(
                      title: "Information",
                      icon: LineAwesomeIcons.info,
                      onPress: (){

                      }),
                  ProfileSetting(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: context.theme.primaryColorDark,
                    endIcon: false,
                    onPress: (){
                      logOut(context, (){
                        setState(() {
                          String str = '0';
                          log("log out");
                          context.push("/home/$str");
                        });
                      });
                    },
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }




  Widget connectionSession() {
    return Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                        image: AssetImage("images/account-2.png"),
                        fit: BoxFit.cover
                    )
                ) ,
              ),
              const SizedBox(height: 10),
              customText("Sorry you are not connect ...", color: Colors.black54, size: 18),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 340,
                child: ElevatedButton(
                    onPressed: (){
                      GoRouter.of(context).go("/login");
                    },
                    style:customStyleButton(),
                    child: customText("login", size: 25, color: Colors.white)
                ),
              ),
              padding(top: 10),
              Container(
                padding: const EdgeInsets.only(right: 30),
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: (){
                    context.go("/sign_in");
                  },
                  child: customText("create Account", color: Colors.blue),
                ),
              )
            ],
          ),
        )
    );
  }



}






