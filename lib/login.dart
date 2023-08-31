import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalapp/signIn.dart';

import 'class/function.dart';

class Log extends StatelessWidget{
  const Log({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
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

class _LoginApp extends State<LoginApp> {
  final emailController = TextEditingController();
  bool passwordVisibility = true;
  var password;
  var email = "marcdev45@gmail.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: GestureDetector(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: SingleChildScrollView(
                padding:const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  customText("Welcome to ", size: 30),
                                  customText("RentApp",
                                      size: 40,
                                      fontSize: FontStyle.italic,
                                      color: Colors.blue)
                                ],
                              ),
                            ),
                            padding(top: 70),
                            Container(
                                width: 300,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blue
                                ),
                                child:customText("login", color: Colors.white, size: 30)
                            ),
                          ]),
                      padding(top: 40),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: customText("Email or Phone number"),
                            ),
                            padding(top: 10),
                            emailBox(),
                            padding(top: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: customText("Enter the password"),
                            ),
                            padding(top: 10),
                            passWordBox(),
                            padding(top: 20),
                            Container(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: ()=>passForget(context),
                                    child: customText("password forget",
                                      color: Colors.blue
                                    )),
                            )
                          ],
                        ),
                      ),
                      padding(top: 60),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (checkEmail(email)) {                         //*************** check email
                              passForget(context);
                            } else {
                              setState(() {
                                Navigator.pop;
                              });
                            }
                          });
                        },
                        style: const ButtonStyle(
                            maximumSize:MaterialStatePropertyAll(Size.fromWidth(300)),
                            fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(40)),
                            backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                        child: customText("Sign In",color: Colors.white, size: 20),
                      ),
                      padding(top: 40),
                      Container(
                        alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){
                                GoRouter.of(context).push("/signIn");
                              },
                              child: customText("create an account")),
                      ),
                    ])
            )));
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
          Icons.email,
          color: Colors.red,
        ),
        suffixIcon: emailController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                emailController.clear();
              });
            })
            : Container(
          width: 0,
        ),
        border: const OutlineInputBorder(),
      ),
      onSubmitted: (String value) => {email = value},
    );
  }

  Widget passWordBox() {
    return TextField(
      obscureText: passwordVisibility,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.key,
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
          border: const OutlineInputBorder()),
      onSubmitted: (String value) {
        password = value;
      },
    );
  }


}
