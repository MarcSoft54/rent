
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/http_services/http_service_user.dart';
import 'package:rentalapp/json/user.dart';
import 'package:rentalapp/login.dart';

import 'class/function.dart';


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

  List<String> items = ["None","Homme", "Femme"];
  String? selectItem = "None";
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


  Future<void> httpPostUser(UserDto user) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/users",
          data: user.toJon());
      if(response.statusCode == 200){
        messages = response.data;
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          padding(top: 20),
                          const Icon(
                            Icons.cabin_outlined,
                            size: 80,
                            color: Colors.blue,
                          ),
                          customText("Create you account",size: 25, fontWeight: FontWeight.bold),
                          customText("Fill in your fields to be able to create",size: 15)
                        ],
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          padding(top: 20),
                          TextField(
                            onSubmitted: (vale){
                              setState(() {
                                username = vale;
                              });
                            },
                            decoration: InputDecoration(
                                label: Row(
                                  children: [
                                    customText("Username"),
                                    customText("*", color: Colors.red)
                                  ],
                                ),
                                hintText: "marc",
                                border: const OutlineInputBorder()
                            ),
                          ),
                          padding(top: 10),
                          TextField(
                            onSubmitted: (val){
                              setState(() {
                                surname = val;
                              });
                            },
                            decoration: InputDecoration(
                                label: Row(
                                  children: [
                                    customText("Username"),
                                    customText("*", color: Colors.red)
                                  ],
                                ),
                                hintText: "dev",
                                border: const OutlineInputBorder()),
                          ),
                          padding(top: 10),
                          TextField(
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
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.red,
                              ),
                              suffixIcon: emailController.text.isNotEmpty
                                  ? IconButton(
                                  icon: const Icon(Icons.close),
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
                          ),
                          padding(top: 10),
                          passWordBox("password"),
                          padding(top: 10),
                          TextField(                            // ****** passWord check
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
                                label: customText("Enter back the same password"),
                                hintText: "password",
                                border: const OutlineInputBorder()),
                            onSubmitted: (String value) {
                              setState(() {
                                password_2 = value;
                              });
                            },
                          ),
                          padding(top: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 90,
                                  height: 52,
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
                                    decoration: const InputDecoration(
                                        label: Text("sex", style: TextStyle(fontSize: 22),),
                                        border: OutlineInputBorder()
                                    ),
                                  )
                              ),
                              padding(left: 2),
                              Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value){
                                      setState(() {
                                        phoneNumber = int.parse(value);
                                      });
                                    },
                                    decoration: InputDecoration(
                                        label: customText("Phone number"),
                                        border: const OutlineInputBorder()
                                    ),
                                  ))
                            ],),
                          padding(top: 40),
                          ElevatedButton(
                            onPressed: (){
                              setState(() {
                                print(
                                    "$username, $surname, $emailUser, $password_2, $sex, $phoneNumber"
                                );
                                print("the message $messages");
                                if(username.isNotEmpty && surname.isNotEmpty && emailUser.isNotEmpty
                                    && sex.isNotEmpty && phoneNumber != 0
                                ){
                                  if(password != password_2){
                                    messages = "Different Pass";
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
                            style: const ButtonStyle(
                                maximumSize:MaterialStatePropertyAll(Size.fromWidth(300)),
                                fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(40)),
                                backgroundColor: MaterialStatePropertyAll(Colors.blue)
                            ),
                            child: customText("connexion", size: 22, color: Colors.white),
                          ),
                          padding(top: 50),
                          customText((b)? "Please verified you information":
                          (messages == "isPresent")?"you are present just sign in,":
                          (messages == "Different Pass")? "check you password...": "", color: Colors.red),
                          padding(top: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customText("have an account"),
                              TextButton(
                                  onPressed: (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                                        return LoginApp();
                                      }));
                                    });
                                  },
                                  child: customText("login here", color: Colors.red[500]))
                            ],
                          ),
                        ]
                    ),
                  ],
                ),
              )),
        ));
  }



  Widget passWordBox(String string){
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
          label: customText(string),
          hintText: string,
          // errorText: "error password",
          border: const OutlineInputBorder()),
      onSubmitted: (String value) {
        password = value;
      },
    );
  }


}
