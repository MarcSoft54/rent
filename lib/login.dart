import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First page',
      theme: ThemeData(
        //useMaterial3: true,
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
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
        // appBar: AppBar(
        // title: const Text("marc dev", style: TextStyle(color: Colors.blue),),
        // backgroundColor: Colors.white,
        // ),
        body: Center(
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                              ),
                              Text(
                                "Welcome to ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
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
                          height: 45,
                          margin: const EdgeInsets.only(
                              left: 10, top: 25, right: 10, bottom: 15),
                          child: const Text(
                            "To connect to your work space just to you you have to abort connect by just entering its two information ...",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Email or Phone number"),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String value) => {
                          // get the email here ...
                        },
                        decoration: InputDecoration(
                            label: const Text("Email"),
                            hintText: "marcdev@gmail.com",
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                            suffixIcon: emailController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => emailController.clear())
                                : Container(
                                    width: 0,
                                  ),
                            border: const OutlineInputBorder()),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Enter the password"),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                      TextField(
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.black,
                            ),
                            label: Text("Password"),
                            hintText: "password",
                            // errorText: "error password",
                            border: OutlineInputBorder()),
                        onSubmitted: (String value) {
                          //password = value;
                        },
                        //obscureText: isPasswordVisibe,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 20)),
                          TextButton(
                              onPressed: null,
                              child: Text(
                                "password forget",
                                style: TextStyle(color: Colors.blue),
                              )),
                          const Padding(padding: EdgeInsets.only(bottom: 7)),
                        ],
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      maximumSize:
                          MaterialStatePropertyAll(Size.fromWidth(300)),
                      fixedSize:
                          MaterialStatePropertyAll<Size>(Size.fromHeight(40)),
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * .2,
                )
              ]),
        )
      ]),
    ));
  }
}
