
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:rentalapp/class/function.dart';

import '../json/message.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listMessage.add(widget.message);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          title: customText("${widget.message.createBy}"),
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
                groupBy: (sms) => DateTime(widget.message.createAt.day),
                groupHeaderBuilder: (Message message){
                  return SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: customText(
                              DateFormat.yMMMd().format(message.createAt), size: 12
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
                        setState(() {
                          text.clear();
                          final message = Message(
                              id: 1,
                              content: sms,
                              createAt: DateTime.now(),
                              createBy: 1
                          );
                          listMessage.add(message);
                        });
                      },
                      icon: const Icon(Icons.send_rounded)),
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