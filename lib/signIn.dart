
import 'package:animator/animator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/json/user.dart';
import 'package:rentalapp/login.dart';

import 'class/function.dart';

class Sign extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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

  // *************************   Variables of the User

  String username = '';
  String surname = '';
  String emailUser = '';
  String password_2 ='';
  int phoneNumber = 0;
  String country = '';
  String sex = "";

  // *********************** end *******************

  String messages = '';
  var statusCode ;


  Future<void> httpPostUser(UserDto user) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/users",
          data: user.toJon());
      if(response.statusCode == 200){
        setState(() {
          messages = response.data;
        });
      }
    }catch(e){
      setState(() {
        statusCode = e;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                            customIcon(Icons.cabin_outlined,colors: Colors.blue,
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
                        height: 45,
                        child: TextField(
                            onSubmitted: (vale){
                              setState(() {
                                username = vale;
                              });
                            },
                            decoration: buildInputDecoration("Username", Icons.person)
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextField(
                            onSubmitted: (val){
                              setState(() {
                                surname = val;
                              });
                            },
                            decoration: buildInputDecoration("Surname", Icons.person)
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSubmitted: (value) {
                            setState(() {
                              emailUser = value;
                            });
                          },
                          decoration: InputDecoration(
                            label: customText("Email"),
                            hintText: "marcdev@gmail.com",
                            prefixIcon: const Icon(Icons.email_outlined,color: Colors.red),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: passWordBox("password")
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextField(                            // ****** passWord check
                          obscureText: passwordVisibility,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.password,
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
                            label: customText("Enter back the same password"),
                            hintText: "password",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),),
                          onSubmitted: (String value) {
                            setState(() {
                              password_2 = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: 90,
                              height: 45,
                              child: DropdownButtonFormField<String>(
                                value: selectItem,
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: customText(item, size: 11)))
                                    .toList(),
                                onChanged: ((val){
                                  setState(() {
                                    sex = val!;
                                  });
                                }),
                              )
                          ),
                          padding(left: 1),
                          Expanded(
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value){
                                    setState(() {
                                      phoneNumber = int.parse(value);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    label: customText("Phone number"),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                                  ),
                                ),
                              ),)
                        ],),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: (){
                            setState(() {
                              // print(
                              //     "$username, $surname, $emailUser, $password_2, $sex, $phoneNumber"
                              // );
                              // print("the message $messages");
                              if(username.isNotEmpty && surname.isNotEmpty && emailUser.isNotEmpty
                                  && sex.isNotEmpty && phoneNumber != 0
                              ){
                                if(password != password_2){
                                  messages = "Different Pass";
                                }else if(statusCode != null){
                                  showNoConnect(context);
                                }else{
                                  UserDto userDto = UserDto(
                                      username,
                                      surname,
                                      emailUser,
                                      password_2,
                                      sex,
                                      phoneNumber,
                                      country);
                                  httpPostUser(userDto);
                                }
                              }else{
                                b = !b;
                              }
                            });
                          },                            // ************ Submit ***********
                          style: customStyleButton(),
                          child: customText("connexion", size: 22, color: Colors.white),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                                    return const LoginApp();
                                  }));
                                });
                              },
                              child: customText("login here", color: Colors.red[500]))
                        ],
                      )
                    ]
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ));
  }



  Widget passWordBox(String string){
    return TextField(
      obscureText: passwordVisibility,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.password,
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
        label: customText(string),
        hintText: string,
        // errorText: "error password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),),
      onSubmitted: (String value) {
        password = value;
      },
    );
  }




}
