
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/class/function.dart';

class EditProfil extends StatelessWidget{

  EditProfil({super.key, required this.id});

  var id;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      home: _EditProfil(id),
    );
  }
}

class _EditProfil extends StatefulWidget{
  const _EditProfil(id);


  @override
  State<_EditProfil> createState() => _Edit();

}

class _Edit extends State<_EditProfil> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120, height: 120,
                    child: ClipRRect(borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage("images/account-2.png"),)),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: PencilModify(
                        icon: LineAwesomeIcons.camera,
                        onPress: () {
                          profitMessage(context);
                        },
                      )
                  )
                ],
              ),
              Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                          decoration: buildInputDecoration(
                              "Username", Icons.person_outline)
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          decoration: buildInputDecoration(
                              "E-mail", Icons.email_outlined)
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          decoration: buildInputDecoration(
                              "Password", Icons.password)
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          decoration: buildInputDecoration(
                              "Country", Icons.flag)
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: buildInputDecoration(
                            "Phone number", Icons.phone),
                      ),
                      const SizedBox(height: 70),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: Text("Edit Profile", style: Theme.of(context).textTheme.headline4,
                              textScaleFactor: .7,)
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.bottomRight,
                        child:   ElevatedButton(
                            onPressed: (){

                            },
                            child: const Text("Delete Account", style: TextStyle(color: Colors.red),)
                        ),
                      ),
                      const SizedBox(height: 120),
                      const Text.rich(
                        TextSpan(
                          text: "Made by @marcdev"
                        )
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
