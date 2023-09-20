import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/login.dart';
import 'package:rentalapp/signIn.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String image ="https://th.bing.com/th/id/R.2039b86fe02a60700c5e0005b5e42191?rik=ikcpeUevqrj53Q&riu=http%3a%2f%2feurekaheritage.com%2fimages%2fHome+Tour+2006%2fHousePhotos%2fIris+House.jpg&ehk=J67SfKCWzU0c4q1REnIbeISmJnqUv5vE5OYofKJUAzA%3d&risl=&pid=ImgRaw&r=0";


  @override
  Widget build(BuildContext context) {
    final int height = MediaQuery.of(context).size.height.toInt();
    final int width = MediaQuery.of(context).size.width.toInt();

    return Scaffold(
        body: Center(
          child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                height:height * .68,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  image,
                                ),
                                fit: BoxFit.cover))),
                    Positioned(
                      bottom: 0,
                        right: 0,
                        child: TextButton.icon(
                          onPressed:(){
                            context.go("/home/null");
                          },
                          icon:Icon(LineAwesomeIcons.forward),
                          label: Text("pass"),
                        )
                    )
                  ],
                )
            ),
            Expanded(
                child: Container(
                  color: Colors.blue,
                  width: width.toDouble(),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          "Find Perfect PLace\n\t for Your Dream",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext){
                                return SignIn();
                              }));
                            });
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.blue),
                            fixedSize: MaterialStatePropertyAll<Size>(Size.fromHeight(40)),
                            maximumSize: MaterialStatePropertyAll(Size.fromWidth(300)),
                          ),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width*.2),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const Text("Already have an Account?"),
                                TextButton(
                                    onPressed:(){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const LoginApp()));
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ]),
                        ),
                        SizedBox(
                          height:height * .01,
                        )
                      ],
                    ),
                  ),
                )),

          ]),
        ));
  }
}
