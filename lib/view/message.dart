
import 'package:animator/animator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/message/messageUpload.dart';
import 'package:rentalapp/json/message.dart';

import '../json/user.dart';
import 'package:rentalapp/class/http/messageHttp.dart';

class MessageView extends StatefulWidget{
  const MessageView({super.key});

  @override
  State<MessageView> createState()=> _MessageView();
}



class _MessageView extends State<MessageView>{

  MessageService messageService = MessageService();


  var messageList ;
  Dio dio = Dio();
  int id = 1;

  User user = User(
      id: 0,
      username: '',
      userPicture: '',
      email: '',
      sex: '',
      country: '',
      phoneNumber: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }



  getMessage() async{
    try{
      Response response = await dio.get("http://localhost:9001/api/messages/$id");
      if(response.statusCode == 200){
        setState(() {
          messageList = response.data;
        });
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customText("Mess", size: 30),
            customText("enger", size: 25, color: Colors.blue, fontSize: FontStyle.italic)
          ],
        ),
      ),
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child:
        (messageList == null)
            ?Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Animator(
                duration: const Duration(milliseconds: 1000),
                cycles: 0,
                curve: Curves.easeInOut,
                tween: Tween(begin: 15.0,end: 25.0),
                builder: (context, animatoState, child) =>
                    customIcon(Icons.cabin_outlined,colors: Colors.blue,
                        size: animatoState.value *5
                    ),
              ),
            )
        ):
        ListView.builder(
            padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
            itemCount: messageList.length,
            itemBuilder: (context, index) {
              Message message = Message.fromJson(messageList[index]);
              var date = DateTime.parse(message.createAt);
              getOneUser(message.createBy);
              return Column(
                children: [
                  ListTile(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context){
                            return MessagePage(message);
                          }));
                    },
                    leading: SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                          image: AssetImage("images/account-2.png"),
                        ),
                      ),
                    ),
                    title: customText(user.username),
                    trailing: customText(DateFormat.yMMMd().format(date)),
                  ),
                  Divider(
                    color: Colors.blueGrey[200],
                    endIndent: 2,
                    indent: 2,
                  )
                ],
              );
            }),
      ),
    );
  }



  getOneUser(var id)async{
    try{
      Response response = await dio.get("http://localhost:9001/api/users/$id");
      if(response.statusCode == 200){
        setState(() {
          user = User.fromJson(response.data);
        });
      }
    }catch(e){
      print(e);
    }
  }

}

//
// (message.content.length > size~/40)
// ? customText("${message.content.substring(0,(size~/40))}...", size: 14)
// : customText(message.content)