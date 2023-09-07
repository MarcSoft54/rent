
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentalapp/acceuil.dart';
import 'package:rentalapp/class/http/userHttp.dart';
import 'package:rentalapp/json/token.dart';

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

class _LoginApp extends State<LoginApp> {
  final emailController = TextEditingController();
  bool passwordVisibility = true;
  var password;
  var email = "marcdev45@gmail.com";
  bool status = false;
  UserService service = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: GestureDetector(
            onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
            child: SingleChildScrollView(
                padding:const EdgeInsets.only(left: 10, right: 10),
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
                                  customText("Welcome to ", size: 25),
                                  customText("RentApp",
                                      size: 35,
                                      fontSize: FontStyle.italic,
                                      color: Colors.blue)
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(left: 60, right: 60),
                                height: 50,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    color: Colors.blue
                                ),
                                child:customText("login", color: Colors.white, size: 30)
                            ),
                          ]),
                      const SizedBox(height: 40),
                      Column(
                        children: [
                          SizedBox(
                            height: 45,
                            child: emailBox(),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 45,
                            child: passWordBox(),
                          ),
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
                                setState(() {
                                  service.getUserId(email, password).then((value){
                                    if(value == null){
                                      status = !status;
                                    }else{
                                      Token token = value;
                                      context.go("/home/${token.id}");
                                    }
                                  });

                                });

                            });
                          },
                          style: customStyleButton(),
                          child: customText("Sign In",color: Colors.white, size: 20),
                        ),
                      ),
                      padding(top: 40),
                      Container(
                        child: (status)? customText("not exit"):customText("Welcome"),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){
                                GoRouter.of(context).push("/signIn");
                              },
                              child: customText("create an account", color: Colors.red)),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0))),
      onSubmitted: (String value) {
        password = value;
      },
    );
  }


}
