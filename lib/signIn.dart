
import 'dart:developer';

import 'package:animator/animator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/json/user.dart';
import 'package:rentalapp/class/http/userHttp.dart';
import 'package:rentalapp/view/profit.dart';

import 'class/function.dart';

class Sign extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue,
          useMaterial3: true
      ),
      home: const SignIn(),
    );
  }
}


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final emailController = TextEditingController();
  bool passwordVisibility = true;
  var password;
  var email = "marcdev45@gmail.com";
  String name = 'marc';

  Dio dio = Dio();

  List<String> items = ["sex","Male", "Female"];
  String? selectItem = "sex";
  bool b = false;

  UserService userService = UserService();

  // *************************   Variables of the User

  String username = '';
  String userPicture = '';
  String emailUser = '';
  String password_2 ='';
  int phoneNumber = 0;
  String country = '';
  String sex = '';

  // *********************** end *******************

  String messages = '';
  var statusCode ;



  Future<void> httpPostUser(UserDto user) async{
    try{
      Response response = await dio.post("http://192.168.43.82:9001/api/users",
          data: user.toJson());
      if(response.statusCode == 200){
        messages = response.data;
      }
    }catch(e){
      statusCode = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.greenAccent.withOpacity(.6),
                        context.theme.primaryColorDark.withOpacity(.5)
                      ]
                  )
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Animator(
                            duration: const Duration(milliseconds: 1000),
                            cycles: 0,
                            curve: Curves.easeInOut,
                            tween: Tween(begin: 15.0,end: 25.0),
                            builder: (context, animatoState, child) =>
                                customIcon(Icons.cabin_outlined,colors: context.theme.primaryColor,
                                    size: animatoState.value *4
                                ),
                          ),
                        ),
                        customText("Create you account",size: 25, fontWeight: FontWeight.bold),
                        customText("Fill in your fields to be able to create",size: 15)
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                        children: [
                          SizedBox(
                            // height: 45,
                            child: TextField(
                                onSubmitted: (vale){
                                  setState(() {
                                    username = vale;
                                  });
                                },
                                decoration: buildInputDecoration("Username", Icons.person_outline, context)
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            // height: 45,
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onSubmitted: (value) {
                                setState(() {
                                  if(checkEmail(value)){
                                    emailUser = value;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                label: customText("Email"),
                                hintText: "marcdev@gmail.com",
                                prefixIcon: Icon(Icons.email_outlined,color: context.theme.primaryColor),
                                suffixIcon: emailController.text.isNotEmpty
                                    ? IconButton(
                                    icon: customIcon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        emailController.clear();
                                      });
                                    })
                                    : Container(
                                  width: 0,
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            // height: 45,
                              child: passWordBox("Password")
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            // height: 45,
                            child: TextField(                            // ****** passWord check
                              obscureText: passwordVisibility,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password_rounded,
                                  color: context.theme.primaryColorDark,
                                ),
                                suffixIcon: IconButton(
                                  icon: (passwordVisibility)
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisibility = !passwordVisibility;
                                    });
                                  },
                                ),
                                label: customText("Confirmed the password"),
                                hintText: "password",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),),
                              onChanged: (String value) {
                                setState(() {
                                  password_2 = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            // height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value){
                                setState(() {
                                  phoneNumber = int.parse(value);
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(LineAwesomeIcons.phone, color: context.theme.primaryColorDark,),
                                label: customText("Phone number"),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            ),
                          ),

                          const SizedBox(height: 50),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: (){
                                log("$username, $emailUser, $sex, $phoneNumber, $userPicture");
                                setState(() {
                                  if(username.isNotEmpty  && emailUser.isNotEmpty
                                      && phoneNumber != 0
                                  ){
                                    if(password != password_2){
                                      messages = "Different Pass";
                                    }else if(statusCode != null){
                                      showNoConnect(context);
                                    }else {
                                      {
                                        UserDto userDto = UserDto(
                                            username,
                                            userPicture,
                                            emailUser,
                                            password_2,
                                            sex,
                                            phoneNumber,
                                            country);
                                        log("$userDto");
                                        httpPostUser(userDto).then((value) => context.go("/login")
                                        );
                                      }
                                    }
                                  }else{
                                    b = !b;
                                  }
                                });
                              },                            // ************ Submit ***********
                              style: customStyleButton(),
                              child: customText("Register", size: 22, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 5),
                          customText((b)? "Please verified you information":
                          (messages == "isPresent")?"you are present just sign in,":
                          (messages == "Different Pass")? "check you password...": "", color: Colors.red),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customText("have an account"),
                              TextButton(
                                  onPressed: (){
                                    setState(() {
                                      context.go("/login");
                                    });
                                  },
                                  child: customText("login here", color: context.theme.primaryColor))
                            ],
                          )
                        ]
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            )
        ));
  }



  Widget passWordBox(String string){
    return TextField(
      obscureText: passwordVisibility,
      decoration: InputDecoration(
        prefixIcon:  Icon(
          Icons.password,
          color: context.theme.primaryColorDark,
        ),
        suffixIcon: IconButton(
          icon: (passwordVisibility)
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              passwordVisibility = !passwordVisibility;
            });
          },
        ),
        label: customText(string),
        hintText: string,
        // errorText: "error password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),),
      onChanged: (String value) {
        password = value;
      },
    );
  }




}
