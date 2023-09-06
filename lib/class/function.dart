import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


Text customText(String data,
    {color = Colors.black,
      double size = 15,
      fontSize = FontStyle.normal,
      fontWeight = FontWeight.normal}) {
  return Text(data,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: fontSize,
          fontWeight: fontWeight));
}


Padding padding(
    {double left = 0,
      double right = 0,
      double top = 0.0,
      double bottom = 0}) {
  return Padding(
      padding: EdgeInsets.only(
          left: left, right: right, top: top, bottom: bottom));
}



bool checkEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}


Icon customIcon(IconData iconData, {colors = Colors.black, size = 30.0}){
  return Icon(
   iconData,
    size: size,
    color: colors,
  );
}

Widget buildImage(String urlImage, int index){
  return Card(
    elevation: 20,
    child: Image.file(File(urlImage), fit: BoxFit.fill,)
  );
}

showNoConnect(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: [
            Column(
              children: [
                customIcon(Icons.wifi_off, size: 80.0, colors: Colors.black38),
                customText("no connexion")
              ],
            )
          ],
        );
      });
}

Future passForget(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: [
            Column(
              children: [
                customIcon(Icons.not_interested_outlined, colors: Colors.red,
                    size: 100.0),
                customText("no available")
              ],
            )
          ],
        );
      });
}

class ProfileSetting extends StatelessWidget {
  const ProfileSetting({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.tealAccent.withOpacity(0.3)
          ),
          child: Icon(icon, color: Colors.blueAccent,),
        ),
        title: Text(title,
          style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor),
          textScaleFactor: 1.1,),
        trailing: endIcon? Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1)
            ),
            child: const Icon(LineAwesomeIcons.angle_right, color: Colors.grey,size: 18.0,)): null
    );
  }
}
class PencilModify extends StatelessWidget {
  const PencilModify({
    super.key, required this.onPress, required this.icon,
  });
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blue
      ),
      child: IconButton(
        icon: Icon(icon, size: 20,color: Colors.black,),
        onPressed: onPress,),
    );
  }
}


Future profitMessage(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText("Change Profit", size: 20),
            ],
          ),
          contentPadding: const EdgeInsets.all(30),
          titlePadding: const EdgeInsets.all(30),
          children: [
            customIcon(Icons.broken_image_outlined, colors: Colors.black38, size: 125.0),
            padding(top: 20),
            customText("Sorry this option is not yet available")
          ],
        );
      });
}

logOut(BuildContext context){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customIcon(Icons.directions_run, colors: Colors.blue),
              customIcon(Icons.arrow_right_alt, colors: Colors.blue),
              Column(
                children: [
                  customIcon(Icons.door_back_door_rounded, colors: Colors.red),
                  customText("exit", color: Colors.red)
                ],
              )
            ],
          ),
          content: Container(
            alignment: Alignment.center,
            height: 30,
            child: customText("are you sure to log out ?"),
          ),
          contentPadding:const EdgeInsets.all(12),
          actions: [
            ElevatedButton(               // log out Option
              onPressed: null,
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
              ),
              child: customText("YES", color: Colors.black, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)
              ),
              child: customText("No", color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        );
      });
}


Future<void> alert(BuildContext context) {
  return showDialog(context: context,
      builder: (context){
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(12),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText("no access", size: 20.0),
            ],
          ),
          titlePadding: const EdgeInsets.all(12.0),
          elevation: 12.0,
          children: [
            Column(
              children: [
                customIcon(Icons.no_accounts, size: 100.0, colors: Colors.red),
                customText("no connect")
              ],
            )
          ],
        );
      });
}

InputDecoration buildInputDecoration(String name, IconData icon) {
  return InputDecoration(
      floatingLabelStyle: const TextStyle(
          color: Colors.blue),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
      label: Text(name),
      prefixIcon: Icon(icon),
  );
}

ButtonStyle customStyleButton() {
  return ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      side: BorderSide.none,
      shape: const StadiumBorder()
  );
}

get(String key) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int? current = await sharedPreferences.getInt(key);
}