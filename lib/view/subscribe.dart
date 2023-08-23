
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/json/user.dart';
import 'package:rentalapp/profit/articleCollection.dart';
import 'package:rentalapp/subscribeViewArticle.dart';

class Subscriber extends StatelessWidget{
  const Subscriber({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      home: const SubscribePage(),
    );
  }
}


class SubscribePage extends StatefulWidget{
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscriberPage();
}


class _SubscriberPage extends State<SubscribePage>{

  User user = User(
      id: 1,
      username: "Marc",
      surname: "dev",
      email: "marcdev@dev.com",
      sex: "male",
      country: "Cameroon",
      phoneNumber: 657284175);

  final List<User> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.add(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              customText("Foll", size: 29),
              customText("owers", size: 25, fontSize: FontStyle.italic, color: Colors.blue)
            ],
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 15, left: 5, right: 5),
            itemCount: 3,
            itemBuilder: (context, index){
              var user1 = user;
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext){
                            return SubArticle(user);
                          }));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration:  BoxDecoration(
                              border: Border.all(),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/account-2.png")
                                ),
                                // color: Colors.black38,
                                borderRadius:const BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                          padding(right: 20),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      customText("${user1.username} ${user1.surname}"),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     customText("Surname : ${user1.surname}"),
                                  //   ],
                                  // ),
                                ],
                              )
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  customText(user1.email),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.blueGrey[200],
                    endIndent: 15,
                    indent: 15,
                  )
                ],
              );
            })
    );
  }


}