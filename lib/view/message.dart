
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/message/messageUpload.dart';
import 'package:rentalapp/json/message.dart';

class MessageView extends StatefulWidget{
  const MessageView({super.key});

  @override
  State<MessageView> createState()=> _MessageView();
}



class _MessageView extends State<MessageView>{
  List<Message> messageList = [];

Message sms = Message(
                      id: 1,
                      content: "Marc William is the best",
                      createAt: DateTime.now(),
                      createBy: 1
                  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageList.add(sms);
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
        child: (messageList.isEmpty)
          ?  const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator()
            ],
          ),
        )
            :ListView.builder(
            padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
            itemCount: messageList.length,
            itemBuilder: (context, index){
              Message message = messageList[index];
              return Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext){
                            return MessagePage(message);
                          }));
                    },
                    child: SizedBox(
                      height: 40,
                      width: size,
                      // padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 45,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/account-2.png")),
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              // color: Colors.blue
                            ),
                          ),
                          padding(left: 8),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText("${message.createBy}"),
                                      padding(left: size*.4),
                                      Container(
                                        child: customText(DateFormat.yMMMMd().format(message.createAt), size: 14),
                                      )
                                    ],
                                  ),
                                  Expanded( // ******************************************* responsive
                                      child: (message.content.length > size~/40)
                                          ? customText("${message.content.substring(0,(size~/40))}...", size: 14)
                                          : customText(message.content)
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
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

}