import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentalapp/class/function.dart';

import '../json/user.dart';


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



  Dio dio = Dio();

  User user = User(
      id: 1,
      username: "BH_54",
      surname: "marc dev",
      email: "marcdev@gmail.com",
      sex: "male",
      country: "Cameroun",
      phoneNumber: 657284175
  );

  // var user;
  String profitPath = '';
  ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  getUser() async{
    Response response = await dio.get("http://localhost:9004/users" );
  }

  Future getProfitImage() async{
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    profitPath = image!.path.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              customText("Work", color: Colors.black, size: 29),
              customText("Space", color: Colors.blue, size: 25, fontSize: FontStyle.italic)
            ],
          ),
        ),

      floatingActionButton: user == null?
      FloatingActionButton(
          onPressed: alert,
        child: customIcon(Icons.upload_outlined, colors: Colors.black38),
      )
      :FloatingActionButton(
        onPressed: (){
          setState(() {
            context.go("/upload/${user.id}");
          });
        },
        child: const Icon(Icons.file_upload_outlined),
      ),
      body: GestureDetector(
        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 25),
          child: user == null?
          connectionSession() : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.black12,
                        image: DecorationImage(image: AssetImage("images/account-2.png"))
                    ),
                  ),
                  IconButton(
                      onPressed: profitMessage,
                      icon: customIcon(Icons.mode, colors: Colors.black38, size: 20.0))
                ],
              ),
              padding(top: 20),
              infos("name",user.username),
              padding(top: 20),
              infos("username",user.surname),
              padding(top: 20),
              infos("email",user.email),
              padding(top: 20),
              infos("sex",user.sex),
              padding(top: 20),
              infos("phone","${user.phoneNumber}"),
              padding(top: 20),
              infos("country",user.country),
              Container(
                alignment: Alignment.topRight,
                padding:const EdgeInsets.only(right: 20, top: 10),
                child: TextButton(
                  onPressed: logOut,
                  child: customText("log out", color: Colors.blue),
                ),
              ),
              Container(
                height: 200,
              ),
              customText("Made by @marcdev", size: 14),
              Container(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Container infos(String object, String inf){
    return Container(
        height: 40,
        width: 300,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black12
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText("$object :", size: 14, color: Colors.black),
            customText(inf, color: Colors.black, size: 12)
          ],
        )
    );
  }

  Future profitMessage() {
    return showDialog(
        context: context,
        builder: (BuildContext){
          return SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customText("Change Profit", size: 20),
                customIcon(Icons.disabled_by_default, colors: Colors.red)
              ],
            ),
            contentPadding: const EdgeInsets.all(30),
            titlePadding: const EdgeInsets.all(30),
            children: [
              customIcon(Icons.broken_image_outlined, colors: Colors.black38, size: 125.0),
              padding(top: 20),
              customText("Sorry this option is not yet available")
            ],
          );
        });
  }

  Future logOut(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext){
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customIcon(Icons.directions_run, colors: Colors.blue),
                customIcon(Icons.arrow_right_alt, colors: Colors.blue),
                Column(
                  children: [
                    customIcon(Icons.door_back_door_rounded, colors: Colors.red),
                    customText("exit", color: Colors.red)
                  ],
                )
              ],
            ),
            content: Container(
              alignment: Alignment.center,
              height: 30,
              child: customText("are you sure to log out ?"),
            ),
            contentPadding:const EdgeInsets.all(12),
            actions: [
              ElevatedButton(               // log out Option
                onPressed: null,
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                ),
                child: customText("YES", color: Colors.black, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(BuildContext);
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue)
                ),
                child: customText("No", color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          );
        });
  }

  Widget connectionSession() {
    return Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                        image: AssetImage("images/account-2.png"),
                        fit: BoxFit.cover
                    )
                ) ,
              ),
              padding(top: 10),
              customText("Sorry you are not connect ...", color: Colors.black38, size: 20),
              padding(top: 10),
              ElevatedButton(
                  onPressed: (){
                    context.go("/login");
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    elevation: MaterialStatePropertyAll(12.0),
                    maximumSize:MaterialStatePropertyAll(Size.fromWidth(300)),
                    fixedSize: MaterialStatePropertyAll(Size.fromHeight(40)),
                  ),
                  child: customText("login", size: 25, color: Colors.white)
              ),
              padding(top: 10),
              Container(
                padding: const EdgeInsets.only(right: 30),
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: (){
                    GoRouter.of(context).go("/signIn");
                  },
                  child: customText("create Account", color: Colors.blue),
                ),
              )
            ],
          ),
        )
    );
  }

  Future<void> alert() {
    return showDialog(context: context,
        builder: (BuildContext context){
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(12),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText("no access", size: 20.0),
          ],
        ),
        titlePadding: const EdgeInsets.all(12.0),
        elevation: 12.0,
        children: [
          Column(

            children: [
              customIcon(Icons.no_accounts, size: 100.0, colors: Colors.red),
              customText("no connect")
            ],
          )
        ],
      );
        });
  }

}


