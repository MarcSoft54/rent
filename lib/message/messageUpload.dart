
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:rentalapp/class/function.dart';

import '../json/message.dart';
import '../json/user.dart';

class MessagePage extends StatefulWidget {

  final Message message;

  const MessagePage(this.message, {super.key});

  @override
  State<MessagePage> createState() => _MessagePage();
}

class _MessagePage extends State<MessagePage>{


  List<Message> listMessage = [];
  final text = TextEditingController();
  String sms = '';
  User user = User(
    id: 0,
    username: "",
    userPicture: "",
    email: "",
    sex: "",
    country: "",
    phoneNumber: 0
  );


  Dio dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listMessage.add(widget.message);
    getOneUser();
    getAllSms();
  }

  Future getAllSms() async{
    try{
      Response response = await dio.get("http://localhost:9001/api/messages/${widget.message.createBy}");
      if(response.statusCode == 200){
        setState(() {
         List<dynamic> list = response.data;
         print(list);
         for(int i=0; i<list.length; i++ ){
           Message message = Message.fromJson(list[i]);
           listMessage.add(message);
         }
        });
      }
    }catch(e){
      print(e);
    }
  }

  getOneUser()async{
    try{
      Response response = await dio.get("http://localhost:9001/api/users/${widget.message.createBy}");
      if(response.statusCode == 200){
        setState(() {
          user = User.fromJson(response.data);
        });
      }
    }catch(e){
      print(e);
    }
  }

  postMessage(MessageDto messageDto, var id) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/messages/$id", data: messageDto.toJson() );
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          title:(user.username.isEmpty)?const Text(" "):customText(user.username),
        ),
        body: Column(
          children: [
            Expanded(
              child: GroupedListView<Message, DateTime>(
                reverse: true,
                padding: const EdgeInsets.all(8),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: listMessage,
                groupBy: (sms) => DateTime.parse(widget.message.createAt),
                groupHeaderBuilder: (Message message){
                  var date = DateTime.parse(widget.message.createAt);
                  return SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: customText(
                              DateFormat.yMMMd().format(date), size: 12
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemBuilder: (context, Message message){
                  return Align(
                      alignment: true
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                        child: Card(
                          elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(message.content),
                            ),

                        ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.only(bottom: 5, left: 2, right: 2),
              child: TextField(
                minLines: 1,
                maxLines: 3,
                maxLength: 500,
                controller: text,
                onChanged: (valeur){
                  setState(() {
                    sms = valeur;
                  });
                },
                decoration: InputDecoration(
                  icon: IconButton(
                      onPressed: (){
                          text.clear();
                           MessageDto messageDto = MessageDto(
                             sms, 2
                           );

                          sms = '';
                          postMessage(messageDto, user.id).then((value){
                            setState(() {
                              listMessage.add(value);
                            });
                          });

                      },
                      icon: const Icon(Icons.send_rounded, color: Colors.blue)
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22))
                  ),
                  hintText: "Write you message here ...",
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            )
          ],
        ),

      ),
    );

  }



}