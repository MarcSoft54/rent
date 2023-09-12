

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/acceuil.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/class/http/userHttp.dart';
import 'package:rentalapp/json/user.dart';
import 'package:rentalapp/view/profit.dart';

class EditProfil extends StatelessWidget{

  EditProfil({super.key, required this.id});

  var id;
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      home: _EditProfil(userId: id,),
    );
  }
}

class _EditProfil extends StatefulWidget{

   const _EditProfil({required this.userId});

  final userId ;

  @override
  State<_EditProfil> createState() => _Edit();

}

class _Edit extends State<_EditProfil> {

  UserService userService = UserService();
  var userPicture;
  var username;
  var email;
  var password;
  var country;
  var phone;

  User user = User(
      id: 0,
      username: '',
      userPicture: '',
      email: '',
      sex: '',
      country: '',
      phoneNumber: 0
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userService.getOneUser(widget.userId).then((value){
      setState(() {
        user = value;
      });
    });
  }


  bool visibility = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120, height: 120,
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: (userPicture ==null)
                            ?const Image(
                          image: AssetImage("images/account-2.png"),)
                            :Image(
                          image: MemoryImage(userPicture),fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: PencilModify(
                        icon: LineAwesomeIcons.camera,
                        onPress: () {
                          setState(() {
                            userService.getPicture().then((value){
                              // List<int> list = value.codeUnits;
                              // Uint8List byte = Uint8List.fromList(value);
                              userPicture = value;
                            }).then((value)=>setState(()=>userPicture));
                          });
                        },
                      )
                  )
                ],
              ),
              Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                          decoration: buildInputDecoration(
                              "Username", Icons.person_outline, context),
                        onChanged: ((value){
                          username = value;
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration(
                              "E-mail", Icons.email_outlined, context),
                        onFieldSubmitted: ((value){
                          setState(() {
                            if(checkEmail(value)){
                              email = value;
                            }else{
                              email = user.email;
                            }
                          });
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                          obscureText: visibility,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(
                                color: context.theme.primaryColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            label: const Text("password"),
                            prefixIcon: Icon(Icons.password, color: context.theme.primaryColorDark,),
                              suffixIcon: IconButton(
                                icon: (visibility)? const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                                onPressed: (){
                                  setState(() {
                                    visibility = !visibility;
                                  });
                                },
                              )
                          ),
                        onFieldSubmitted: ((value){
                          setState(() {
                            password = value;
                          });
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              "Country", Icons.flag, context),
                        onFieldSubmitted: ((value){
                          setState(() {
                            country = value;
                          });
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: buildInputDecoration(
                            "Phone number", Icons.phone, context),
                        onFieldSubmitted: ((value){
                          phone = value;
                        }),
                      ),
                      const SizedBox(height: 70),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                userService.getOneUser(widget.userId).then((value){
                                  user = value;
                                });
                              });
                              UserDto user1 = UserDto(
                                  username,
                                  String.fromCharCodes(userPicture),
                                  email,
                                  password,
                                  user.sex,
                                  int.parse(phone),
                                  country);
                              userService.putUser(user1, int.parse(widget.userId)).then((value){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return Home(id: widget.userId);
                                    }));
                                  });
                              });

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: context.theme.primaryColorDark,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: Text("Edit Profile", style: Theme.of(context).textTheme.headlineLarge,
                              textScaleFactor: .7,)
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.bottomRight,
                        child:   ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(context.theme.primaryColorDark)
                          ),
                            onPressed: (){
                              String str = '0';
                              userService.delUser(widget.userId).then((val){
                                context.push("/home/$str");
                              });
                            },
                            child: Text("Delete Account", style: context.theme.textTheme.titleMedium,)
                        ),
                      ),
                      const SizedBox(height: 120),
                      Text.rich(
                        TextSpan(
                          text: "Made by @marcdev",
                          style: context.theme.textTheme.titleSmall
                        )
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
