
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/class/messageUpload.dart';
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
              return InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext){
                        return MessagePage(message);
                      }));
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                    elevation: 12,
                    child: customText("Hello world"),
                  ),
                ),
              );
            }),
      ),
    );
  }

}