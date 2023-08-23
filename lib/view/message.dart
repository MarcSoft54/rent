
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/message/messageUpload.dart';
import 'package:rentalapp/json/message.dart';

class MessageView extends StatefulWidget{
  const MessageView({super.key});

  @override
  State<MessageView> createState()=> _MessageView();
}

List<Message> messageList = [];

class _MessageView extends State<MessageView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText("Messengers"),
      ),
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index){
              Message message = Message(id: 2,
                  content: "content",
                  createAt: "25/01/3302",
                  createBy: "Marc");
              return Container(
                padding:const EdgeInsets.only(left: 2,right: 2),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext){
                              return MessagePage(message);
                            }));
                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: customText("Hello world"),
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey[200],
                      endIndent: 15,
                      indent: 15,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

}