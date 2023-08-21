
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';

import '../json/message.dart';

class MessagePage extends StatelessWidget{

  final Message message;
  const MessagePage(this.message,{super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(message.createBy),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return Container(
            height: 45,
            padding:const EdgeInsets.only(left: 5, bottom: 5),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: IconButton(
                    icon: customIcon(Icons.send, colors: Colors.blueAccent, size: 30.0),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



}