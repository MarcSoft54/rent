

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/class/http/userHttp.dart';
import 'package:rentalapp/json/user.dart';

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

   _EditProfil({required this.userId});

  var userId ;

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
                          image: FileImage(File(userPicture)),fit: BoxFit.cover,
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
                              "Username", Icons.person_outline),
                        onChanged: ((value){
                          username = value;
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                          decoration: buildInputDecoration(
                              "E-mail", Icons.email_outlined),
                        onFieldSubmitted: ((value){
                          setState(() {
                            if(checkEmail(value)){
                              email = value;
                            }else{
                              email = "";
                            }
                          });
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                          obscureText: visibility,
                          decoration: InputDecoration(
                            floatingLabelStyle: const TextStyle(
                                color: Colors.blue),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                            label: const Text("password"),
                            prefixIcon: const Icon(Icons.password),
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
                              "Country", Icons.flag),
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
                            "Phone number", Icons.phone),
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
                                  userPicture,
                                  email,
                                  password,
                                  user.sex,
                                  phone,
                                  country);
                              userService.putUser(user1, widget.userId);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: Text("Edit Profile", style: Theme.of(context).textTheme.headline4,
                              textScaleFactor: .7,)
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.bottomRight,
                        child:   ElevatedButton(
                            onPressed: (){
                              userService.delUser(widget.userId);
                            },
                            child: const Text("Delete Account", style: TextStyle(color: Colors.red),)
                        ),
                      ),
                      const SizedBox(height: 120),
                      const Text.rich(
                        TextSpan(
                          text: "Made by @marcdev"
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
