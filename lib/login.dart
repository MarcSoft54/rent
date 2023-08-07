import 'package:flutter/material.dart';
import 'package:rentalapp/signIn.dart';

import 'class/function.dart';

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
        body: GestureDetector(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 25,
                                    ),
                                    const Text(
                                      "Welcome to ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "RentApp",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.blue,
                                width: 300,
                                height: 45,
                                padding: const EdgeInsets.only(top: 5),
                                margin: const EdgeInsets.only(
                                  top: 25,
                                  left: 10,
                                  right: 10,
                                ),
                                child: const Text(
                                  "login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ]),
                        Container(
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Email or Phone number"),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              emailBox(),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text("Enter the password")],
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 15)),
                              passWordBox(),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 50)),
                                  TextButton(
                                      onPressed: null,
                                      child: Text(
                                        "password forget",
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  Padding(padding: EdgeInsets.only(bottom: 7)),
                                ],
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (checkEmail(email)) {                         //*************** check email
                                //
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
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            customText("create an account"),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                                    return SignIn();
                                  }));
                                }, 
                                child: customText("here", color: Colors.red[500])),
                            padding(right: 10)
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * .2,
                        )
                      ]),
                )
              ]),
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
          // errorText: "error password",
          border: const OutlineInputBorder()),
      onSubmitted: (String value) {
        password = value;
      },
    );
  }
}
