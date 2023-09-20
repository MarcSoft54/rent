
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalapp/class/http/userHttp.dart';
import 'package:rentalapp/json/loginDTO.dart';
import 'package:rentalapp/json/token.dart';
import 'package:rentalapp/view/profit.dart';

import 'class/function.dart';

class Log extends StatelessWidget{
  const Log({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
      ),
      home: const LoginApp(),
    );
  }
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginApp();
}

class _LoginApp extends State<LoginApp> with SingleTickerProviderStateMixin{

  final emailController = TextEditingController();
  bool passwordVisibility = true;
  var password;
  var email ;
  bool status = false;
  UserService service = UserService();
  bool alerts = false;
  String alertBox = 'check you information';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.greenAccent.withOpacity(.5),
                          context.theme.primaryColorDark.withOpacity(.5)
                        ]
                    )
                ),
                child:
                SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 100),
                  child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: Icon(Icons.cabin_outlined, size: 100,color: context.theme.primaryColorDark,),
                        ),
                        const SizedBox(height: 100),
                        Column(
                          children: [
                            emailBox(),
                            const SizedBox(height: 20),
                            passWordBox(),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: ()=>passForget(context),
                                  child: customText("password forget", color: Colors.blue
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 45,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if(email == null || password == null){
                                setState(() {
                                  alerts = !alerts;
                                });
                                }else{
                                  log("$email et $password");
                                  LoginDto loginDto = LoginDto(email, password);
                                  log(loginDto.email);
                                  service.getUserId(loginDto).then((value){
                                    if(value == null){
                                      log("ici : $value");
                                      status = !status;
                                    }else{
                                      Token token = value;
                                      log(token.accessToken);
                                      context.go("/home/${token.accessToken}");
                                    }
                                  });
                                }
                              });
                            },
                            style: customStyleButton(),
                            child: customText("connect",color: Colors.white, size: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: alerts?Text(alertBox, style: const TextStyle(color: Colors.redAccent, fontSize: 20),):Container(),
                        ),
                        Container(
                          child: (status)? customText("not exit"):customText(""),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){
                                context.go("/sign_in");
                              },
                              child: customText("create an account", color: context.theme.primaryColorDark)),
                        ),
                      ]) ,
                )
            )
        ));
  }

  Widget emailBox() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      decoration: InputDecoration(
        label: const Text("Email"),
        hintText: "marcdev@gmail.com",
        prefixIcon: const Icon(
          Icons.email_outlined,
          color: Colors.red,
        ),
        suffixIcon: emailController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                emailController.clear();
                email = null;
              });
            })
            : Container(
          width: 0,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
    );
  }

  Widget passWordBox() {
    return TextField(
      obscureText: passwordVisibility,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.black,
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
          label: const Text("Password"),
          hintText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))
      ),
      onChanged: (String value) {
        password = value;
      },
    );
  }


}

