import 'package:flutter/material.dart';
import 'package:we_text_2/api/apis.dart';
import 'package:we_text_2/models/messages.dart';

import '../main.dart';

class MessageCard extends StatefulWidget{
  const  MessageCard({super.key, required this.message});

  final Messages message;

  @override
  State<StatefulWidget> createState()=> MessageCardState();

}

class MessageCardState extends State<MessageCard>{
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  //Sender or another user message
  Widget _blueMessage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, //adds maximum possible space between elements of row
      children: [
        //message content
        Flexible(//flexible won't let message long messages overflow and it will take only necessary space
          child: Container(
            padding: EdgeInsets.all(mq.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal: mq.width * .04, vertical:  mq.height * .01
            ),
            decoration: BoxDecoration(
                color: APIs.hexToColor('#ccf2ff'),
              border: Border.all(color: Colors.lightBlueAccent,width: 2.5),
              //Making border radius
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomRight: Radius.circular(30))
            ),
            child: Text(widget.message.msg),
          ),
        ),

        //Received Time
        Padding(
          padding:  EdgeInsets.only(right: mq.width * .04),
          child: Text(
            widget.message.sent,
            style: TextStyle(fontSize: 14,color: Colors.grey),
          ),
        ),
      ],
    );
  }

//Our own message
  Widget _greenMessage() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //adds maximum possible space between elements of row
        children: [
          Row(
            children: [
              //for adding some space
              SizedBox(width: mq.width * .04,),

              //Double blue tick for message read confirmation
              Icon(Icons.done_all_sharp,color: Colors.blue,size: 19,),

              //for adding some space
              SizedBox(width: mq.width * .01,),

              //Sent time
              Text(
                '${widget.message.read}12 AM',
                style: TextStyle(fontSize: 14,color: Colors.grey),
              ),
            ],
          ),

          //message content
          Flexible(//flexible won't let message long messages overflow and it will take only necessary space
            child: Container(
              padding: EdgeInsets.all(mq.width * .04),
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical:  mq.height * .01
              ),
              decoration: BoxDecoration(
                  color: APIs.hexToColor('#b3ffb3'),
                  border: Border.all(color: Colors.green,width: 2.5),
                  //Making border radius
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(30))
              ),
              child: Text(widget.message.msg),
            ),
          ),

        ],
      ),
    );
  }
}