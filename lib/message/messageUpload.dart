
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

import '../json/message.dart';

class MessagePage extends StatelessWidget{

  final Message message;
  const MessagePage(this.message,{super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          title: customText(message.createBy),
        ),
        bottomSheet: BottomSheet(
          onClosing: () {  },
          builder: (BuildContext context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width*.85,
                  padding: const EdgeInsets.only(bottom: 5, left: 2),
                  child: const TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write you message here ...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0))
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: null,
                    icon: customIcon(Icons.send, colors: Colors.blue, size: 30.0)
                )
              ],
            );
          },
        ),
      ),
    );

  }



}